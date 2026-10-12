CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_AUFTRAGSTYP_SPR_ZU_2(
	AUFTRAGSTYP_ID,
	AUFTRAGSTYP_BEZ
) AS
  --2022-08-22, AP0133256,SPEC0166769,dknop, initial
  SELECT 
   0 AS auftragstyp_id
  ,'Standard' AS auftragstyp_bez 
  UNION
SELECT 
   1 AS auftragstyp_id
  ,'Wartung' AS auftragstyp_bez 
  UNION
SELECT 
   2 AS auftragstyp_id
  ,'Ausfall' AS auftragstyp_bez 
  UNION
  SELECT 
   3 AS auftragstyp_id
  ,'Ausfall + Wartung' AS auftragstyp_bez;