CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_MANDANT_WRG_KURS_ZU_HILF_2(
	MANDANT_ID,
	WRG_ID,
	WRG_TYP_ID,
	KURS_2,
	UMRECHNUNGSKURS,
	KURS_DAT_VON,
	KURS_DAT_BIS
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
   

   SELECT
   mwt.mandant_id,
   mwt.wrg_id,
   mwt.wrg_typ_id,
   CASE WHEN wrg_typ_id = 0 THEN lw.umrechnungskurs ELSE 1.0000000 END AS kurs_2,
   ROUND(1/ kurs_2,2) AS umrechnungskurs,
   TO_DATE('1900-01-01')  kurs_dat_von,
   TO_DATE('9999-12-31')  kurs_dat_bis
   FROM dbp_view.v_mandant_wrg_typ_zu_2  mwt
   INNER JOIN dbp_view.v_mandant_2 m
   ON mwt.mandant_id = m.mandant_id
   INNER JOIN dbp_view.v_kurs_2 lw
   ON lw.von_wrg_id = m.default_wrg
   AND lw.nach_wrg_id = 'EUR'
   AND  lw.kurstyp_id = 3
   AND lw.dat_bis = '9999-12-31';