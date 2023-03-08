const cds = require('@sap/cds');
const { PassThrough, Writable } = require('node:stream');
const XLSX = require("xlsx");

module.exports = cds.service.impl(async function () {
    const {
        MeeInfo,
        ExcelUpload,
        Uploads,
        ManufacturerOORRecords,
        FieldMapping,
        Template
    } = this.entities;



    this.on("READ", MeeInfo, async (req) => {
        return {
            MeeID: req.user.id,
            MeeName: "meee"
        }
    })
    this.on('PUT', ExcelUpload, async (req, next) => {
        // const oTemplate = await SELECT.one(Template).where({template_ID : '1001'})
        // let aMappings = await SELECT.from(FieldMapping).where({to_template_ID: oTemplate.ID})

        const mappings = [
            {excel: 'PO', db: 'shortCodePO'},
            {excel: 'BMC PO', db: 'bmcPONumber' , mandatory: true},
            {excel: 'Model', db: 'description' , mandatory: true},
            {excel: 'S/N', db: 'partSupplierPONumber'},
            {excel: 'SKU', db: 'SKU'},
            {excel: 'Colorway', db: 'color'},
            {excel: "Order Q'TY", db: 'orderQuantity'},
            {excel: "Comment -1 (PARTS ETA)", db: 'commentUnparsed'},
        ]

        if (req.data.excel) {
            var entity = req.headers.slug;
            const filename = req.headers.filename;
            const stream = new PassThrough();
            var buffers = [];
            req.data.excel.pipe(stream);
            await new Promise((resolve, reject) => {
                stream.on('data', dataChunk => {
                    buffers.push(dataChunk);
                });
                stream.on('end', async () => {
                    var buffer = Buffer.concat(buffers);
                    var workbook = XLSX.read(buffer, { type: "buffer", cellText: true, cellDates: true, dateNF: 'dd"."mm"."yyyy', cellNF: true, rawNumbers: false });
                    let data = []
                    let error = []
                    const sheets = workbook.SheetNames
                    for (let i = 0; i < sheets.length; i++) {
                        const temp = XLSX.utils.sheet_to_json(
                            workbook.Sheets[workbook.SheetNames[i]], { cellText: true, cellDates: true, dateNF: 'dd"."mm"."yyyy', rawNumbers: false })
                        temp.forEach((res, index) => {
                            if (index === 0) return;
                            const newObj = {filename};
                             mappings.forEach((elem) => {
                                newObj[elem.db] = res[elem.excel]
                            })
                            if(!newObj.SKU){
                                error.push({
                                    type: "Error",
                                    fieldName : "SKU",
                                    line : index,
                                })
                            } else {
                                data.push(JSON.parse(JSON.stringify(newObj)))
                            }                            
                        })
                    }
                    if(error.length >= 1 ){
                        const errorCall = await CallEntity("UploadErrorLog", error)
                    }
                    if (data) {
                        const responseCall = await CallEntity(entity, data);

                        if (responseCall == -1){
                            reject(req.error(400, error));
                        }
                        else {
                            resolve(req.notify({
                                message: 'Upload Successful',
                                status: 200
                            }));
                        }
                    }
                });
            });
        } else {
            return next();
        }
    });
    async function CallEntity(entity, data) {
        let srv = await cds.connect.to('POService');
        if (entity === 'ManufacturerOORRecords' ) {
            let filename = data[0]?.filename;
            let query = INSERT({filename,records: data.length}).into("Uploads");
            await srv.run(query);
        }
        const insertQuery = INSERT.into(entity).entries(data); 
        // This calls the service handler of respective entity. It can be used if any custom 
        // validations need to be performed. or else custom handlers can be skipped. 
        
        const insertResult = await srv.run(insertQuery);
        let query = SELECT.from(entity);
        await srv.run(query);
        return insertResult; //returns response to excel upload entity
    };
});