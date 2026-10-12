create or replace view IDQ_PRODUCTION.DWH.REF_RULE_SYS_CHECK_2(
	REF_RULE_ID,
	REF_RULE_ID_DE,
	REF_RULE_ID_EN,
	REF_RULE_TYPE_ID,
	CATALOG_ID,
	REF_FIELD_ID,
	RULE_TECHNICAL_NAME,
	RULE_SHORT_DESCRIPTION,
	RULE_SHORT_DESCRIPTION_DE,
	RULE_SHORT_DESCRIPTION_EN,
	RULE_DESCRIPTION,
	RULE_DESCRIPTION_DE,
	RULE_DESCRIPTION_EN,
	REF_CRITICALITY_ID,
	REF_DIMENSION_ID,
	ERROR_TEXT,
	ERROR_TEXT_DE,
	ERROR_TEXT_EN,
	VERSION,
	REF_STATUS_ID,
	FIRST_IDQ_RELEASE,
	REF_SOURCE_SYSTEM_TYPE_ID,
	SDC_OBJECT_ID,
	SDC_OBJECT_INFO,
	RULE_DOCU,
	SOLUTION
) as
SELECT                   RR.ID AS REF_RULE_ID, RR.ID AS REF_RULE_ID_DE, RR.ID AS REF_RULE_ID_EN, RR.RULE_TYPE_ID AS REF_RULE_TYPE_ID, RR.CATALOG_ID, RR.FIELD_ID AS REF_FIELD_ID, 
                         RR.NAME AS RULE_TECHNICAL_NAME, RR.SHORT_DESCRIPTION_DE AS RULE_SHORT_DESCRIPTION, RR.SHORT_DESCRIPTION_DE AS RULE_SHORT_DESCRIPTION_DE, 
                         RR.SHORT_DESCRIPTION_EN AS RULE_SHORT_DESCRIPTION_EN, RR.DESCRIPTION_DE AS RULE_DESCRIPTION, RR.DESCRIPTION_DE AS RULE_DESCRIPTION_DE, 
                         RR.DESCRIPTION_EN AS RULE_DESCRIPTION_EN, RR.CRITICALITY_ID AS REF_CRITICALITY_ID, RR.DIMENSION_ID AS REF_DIMENSION_ID, RR.ERROR_TEXT_DE AS ERROR_TEXT, RR.ERROR_TEXT_DE, 
                         RR.ERROR_TEXT_EN, RR.VERSION, RR.STATUS_ID AS REF_STATUS_ID, RR.FIRST_IDQ_RELEASE, RF.SOURCE_SYSTEM_TYPE_ID AS REF_SOURCE_SYSTEM_TYPE_ID,
                         
                         'https://sdc-prod.sys.schwarz/MH-SDC/dg/index.jsp#/abvdl-component?objectViewType=DETAILS&objID=' || TO_VARCHAR(RR.SDC_OBJECT_ID) as SDC_OBJECT_ID,
                         
						 '<a href=""' || 'https://sdc-prod.sys.schwarz/MH-SDC/dg/index.jsp#/abvdl-component?objectViewType=DETAILS&objID=' || TO_VARCHAR(RR.SDC_OBJECT_ID) || '"" target=""_blank""><img src=""'|| 'https://confluence.schwarz/download/thumbnails/61351724/Info-Icon.png?version=1&modificationDate=1605254618000&api=v2"" width=""24"" height=""24"">'
                          || '</img></a>' AS SDC_OBJECT_INFO,

CASE                     WHEN RF.SOURCE_SYSTEM_TYPE_ID = 2 THEN '<A HREF=""' || 'https://confluence.schwarz/download/attachments/238783555/' || TO_VARCHAR(RR.ID) 
                         || '_' || RR.SHORT_DESCRIPTION_DE || '.pdf?api=v2"" target=""_blank""><img src=""https://confluence.schwarz/download/thumbnails/61351724/Info-Icon.png?version=1&modificationDate=1605254618000&api=v2"" width=""24"" height=""24"">'
                          || '</img></A>' WHEN RF.SOURCE_SYSTEM_TYPE_ID = 3 THEN '<A HREF=""' || 'https://confluence.schwarz/download/attachments/70145386/' || TO_VARCHAR(RR.ID) 
                         || '_' || RR.SHORT_DESCRIPTION_DE || '.docx?api=v2"" target=""_blank""><img src=""https://confluence.schwarz/download/thumbnails/61351724/Info-Icon.png?version=1&modificationDate=1605254618000&api=v2"" width=""24"" height=""24"">'
                          || '</img></A>' WHEN RF.SOURCE_SYSTEM_TYPE_ID = 1 THEN '<A HREF=""' || 'https://confluence.schwarz/download/attachments/98451080/' || TO_VARCHAR(RR.ID) 
                         || '.pdf?api=v2"" target=""_blank""><img src=""https://confluence.schwarz/download/thumbnails/61351724/Info-Icon.png?version=1&modificationDate=1605254618000&api=v2"" width=""24"" height=""24"">' || '</img></A>'
                          WHEN RF.SOURCE_SYSTEM_TYPE_ID = 8 THEN '<A HREF=""' || 'https://confluence.schwarz/download/attachments/76855933/' || TO_VARCHAR(RR.ID)
                         || '_' || RR.SHORT_DESCRIPTION_DE || '.docx?api=v2"" target=""_blank""><img src=""https://confluence.schwarz/download/thumbnails/61351724/Info-Icon.png?version=1&modificationDate=1605254618000&api=v2"" width=""24"" height=""24"">'
                          || '</img></A>' WHEN RF.SOURCE_SYSTEM_TYPE_ID = 14 THEN '<A HREF=""""' || TO_VARCHAR(RR.ID)
                         || '"" target=""_blank""> <img src=""https://confluence.schwarz/download/thumbnails/61351724/Info-Icon.png?version=1&modificationDate=1605254618000&api=v2"" width=""24"" height=""24"">' || '</img></A>' END AS RULE_DOCU,
                         RR.SOLUTION

                         
FROM            IDQ_RESULTS.REF_RULE_2 AS RR 
                INNER JOIN
                IDQ_RESULTS.REF_FIELD_2 AS RF ON RR.FIELD_ID = RF.ID
WHERE        (RR.RULE_TYPE_ID = 1);