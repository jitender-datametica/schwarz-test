CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_CHECKBOX(
	 checkbox_fg
	,checkbox_cd
	,checkbox_descr
) AS
SELECT
     dim.CHECKBOX_FG 
	,dim.CHECKBOX_CD
    ,dim.CHECKBOX_DESCR  
FROM 
(
SELECT 
     column1 AS checkbox_fg
	,column2 AS checkbox_cd
    ,column3 AS checkbox_descr
FROM
VALUES
     ('FALSE','O','Checkbox ist nicht ausgewählt')
    ,('TRUE','X','Checkbox ist ausgewählt')
) dim;