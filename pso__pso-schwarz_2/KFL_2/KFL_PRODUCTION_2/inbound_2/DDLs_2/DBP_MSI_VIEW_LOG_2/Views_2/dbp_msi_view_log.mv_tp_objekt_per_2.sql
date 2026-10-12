CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_TP_OBJEKT_PER_2(
	MANDANT_ID,
	TP_OBJEKT_ID,
	DAT_VON,
	TECHN_PLATZ_ID,
	DAT_BIS,
	TP_OBJEKT_TYP,
	HERSTELLER_NAME,
	HERSTELLER_LAND_ID,
	HERSTELLER_TYP_BEZ,
	HERSTELLER_SERIAL_ID,
	BAU_KJ,
	BAU_KJMO,
	BAU_MO,
	BAU_DATE,
	DAT_GEWAEHRLEISTUNG_START,
	DAT_GEWAEHRLEISTUNG_START_BEZ,
	DAT_GEWAEHRLEISTUNG_ENDE,
	DAT_GEWAEHRLEISTUNG_ENDE_BEZ,
	TP_OBJEKT_NR,
	WERK_ID
) AS
--2022-08-29, AP0133256,SPEC0166769,dknop, initial
--2023-02-14, dknop, adding DAT_GEWAEHRLEISTUNG_START_BEZ and DAT_GEWAEHRLEISTUNG_ENDE_BEZ
 --2023-03-20, dknop, adding werk_id
 SELECT 
         tp_o_per.mandant_id
        ,tp_o_per.tp_objekt_id
        ,tp_o_per.dat_von
        ,tp_o_per.techn_platz_id
        ,tp_o_per.dat_bis
        ,tp_objekt_typ
        ,tp_o_per.hersteller_name
        ,tp_o_per.hersteller_land_id
        ,tp_o_per.hersteller_typ_bez
        ,tp_o_per.hersteller_serial_id
        ,NULLIFZERO(tp_o_per.bau_kj) AS bau_kj
        ,tp_o_per.bau_kjmo
        ,CASE WHEN LEN(tp_o_per.bau_kjmo)=6 THEN RIGHT(tp_o_per.bau_kjmo,2) ELSE NULL END AS bau_mo
        ,CASE WHEN LEN(tp_o_per.bau_kjmo)=6 THEN CASE WHEN RIGHT(tp_o_per.bau_kjmo,2)='00' THEN NULL ELSE TO_DATE(CONCAT(tp_o_per.bau_kjmo,'01'),'YYYYMMDD')END ELSE NULL END AS bau_date             
        ,tp_o_per.dat_gewaehrleistung_start
        ,CASE WHEN tp_o_per.dat_gewaehrleistung_start='1900-01-01'THEN NULL ELSE tp_o_per.dat_gewaehrleistung_start END AS dat_gewaehrleistung_start_bez
        ,tp_o_per.dat_gewaehrleistung_ende
        ,CASE WHEN tp_o_per.dat_gewaehrleistung_ende='1900-01-01'THEN NULL ELSE tp_o_per.dat_gewaehrleistung_ende END AS dat_gewaehrleistung_ende_bez
        ,tp_o_per.tp_objekt_nr
        ,in_w.werk_id

FROM dbp_view.v_tp_objekt_per_2 tp_o_per
JOIN dbp_view.v_techn_platz_per_2 tech_pl
ON tp_o_per.mandant_id=tech_pl.mandant_id
AND tp_o_per.techn_platz_id=tech_pl.techn_platz_id
AND tech_pl.dat_bis='9999-12-31' 
JOIN dbp_view.v_in_werk_2 in_w
ON tech_pl.mandant_id= in_w.mandant_id
AND tech_pl.werk_instandhaltung_plan = in_w.werk_nr
WHERE tp_o_per.dat_bis='9999-12-31' ;