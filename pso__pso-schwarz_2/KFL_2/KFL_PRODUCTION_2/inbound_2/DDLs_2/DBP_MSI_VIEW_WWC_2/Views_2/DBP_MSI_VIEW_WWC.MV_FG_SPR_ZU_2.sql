CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_FG_SPR_ZU_2
-- intern, srom, Es gibt ein Element Prompt auf mv_iseg.nullzaehl_fg und keine Lookup Tabelle
-- damit nicht die komplette Tabelle abgefragt wird, hier ein dummy_2 lookup
AS
SELECT fg_id
      ,fg_kbez
FROM (SELECT Cast(1 AS NUMBER(38,0)) AS fg_id
            ,Cast('X' AS VARCHAR(1)) AS fg_kbez) v01
UNION
SELECT fg_id
      ,fg_kbez
FROM (SELECT Cast(0 AS NUMBER(38,0)) AS fg_id
            ,Cast(' ' AS VARCHAR(1)) AS fg_kbez) v02
;