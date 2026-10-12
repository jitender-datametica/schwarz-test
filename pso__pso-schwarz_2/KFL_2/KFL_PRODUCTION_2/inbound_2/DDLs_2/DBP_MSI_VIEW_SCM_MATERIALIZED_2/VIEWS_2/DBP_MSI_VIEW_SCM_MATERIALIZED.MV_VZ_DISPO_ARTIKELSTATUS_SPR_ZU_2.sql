create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_VZ_DISPO_ARTIKELSTATUS_SPR_ZU_2(
	VZ_DISPO_ARTIKELSTATUS_ID,
	MANDANT_ID,
	VZ_DISPO_ARTIKELSTATUS_BEZ,
	VZ_DISPO_ARTIKELSTATUS_BEZ_DE,
	VZ_DISPO_ARTIKELSTATUS_BEZ_CZ,
	VZ_DISPO_ARTIKELSTATUS_BEZ_SK,
	VZ_DISPO_ARTIKELSTATUS_BEZ_HR,
	VZ_DISPO_ARTIKELSTATUS_BEZ_PL,
	VZ_DISPO_ARTIKELSTATUS_BEZ_RO,
	VZ_DISPO_ARTIKELSTATUS_BEZ_BG
) as
--  2023-08-19, dknop, initial
SELECT
 v01.vz_dispo_artikelstatus_id
,v01.mandant_id
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.vz_dispo_artikelstatus_bez END) AS vz_dispo_artikelstatus_bez -- standard == DE
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.vz_dispo_artikelstatus_bez END) AS vz_dispo_artikelstatus_bez_de -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.vz_dispo_artikelstatus_bez END),vz_dispo_artikelstatus_bez_de) AS vz_dispo_artikelstatus_bez_cz -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.vz_dispo_artikelstatus_bez END),vz_dispo_artikelstatus_bez_de) AS vz_dispo_artikelstatus_bez_sk -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id = 65 THEN v01.vz_dispo_artikelstatus_bez END),vz_dispo_artikelstatus_bez_de) AS vz_dispo_artikelstatus_bez_hr -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id = 90 THEN v01.vz_dispo_artikelstatus_bez END),vz_dispo_artikelstatus_bez_de) AS vz_dispo_artikelstatus_bez_pl -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id = 95 THEN v01.vz_dispo_artikelstatus_bez END),vz_dispo_artikelstatus_bez_de) AS vz_dispo_artikelstatus_bez_ro -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id = 18 THEN v01.vz_dispo_artikelstatus_bez END),vz_dispo_artikelstatus_bez_de) AS vz_dispo_artikelstatus_bez_bg -- BG
FROM dbp_view.v_vz_dispo_artikelstatus_spr_zu_2 v01

GROUP BY v01.vz_dispo_artikelstatus_id, v01.mandant_id;