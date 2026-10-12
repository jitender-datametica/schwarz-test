create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_VZ_DISPO_STATUS_SPR_ZU_1(
	VZ_DISPO_STATUS_ID,
	MANDANT_ID,
	VZ_DISPO_STATUS_BEZ,
	VZ_DISPO_STATUS_BEZ_DE,
	VZ_DISPO_STATUS_BEZ_CZ,
	VZ_DISPO_STATUS_BEZ_SK,
	VZ_DISPO_STATUS_BEZ_HR,
	VZ_DISPO_STATUS_BEZ_PL,
	VZ_DISPO_STATUS_BEZ_RO,
	VZ_DISPO_STATUS_BEZ_BG
) as
--  2023-08_18, dknop, initial
SELECT
 v01.vz_dispo_status_id
,v01.mandant_id
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.vz_dispo_status_bez END) AS vz_dispo_status_bez -- standard == DE
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.vz_dispo_status_bez END) AS vz_dispo_status_bez_de -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.vz_dispo_status_bez END),vz_dispo_status_bez_de) AS vz_dispo_status_bez_cz -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.vz_dispo_status_bez END),vz_dispo_status_bez_de) AS vz_dispo_status_bez_sk -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id = 65 THEN v01.vz_dispo_status_bez END),vz_dispo_status_bez_de) AS vz_dispo_status_bez_hr -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id = 90 THEN v01.vz_dispo_status_bez END),vz_dispo_status_bez_de) AS vz_dispo_status_bez_pl -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id = 95 THEN v01.vz_dispo_status_bez END),vz_dispo_status_bez_de) AS vz_dispo_status_bez_ro -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id = 18 THEN v01.vz_dispo_status_bez END),vz_dispo_status_bez_de) AS vz_dispo_status_bez_bg -- BG
FROM dbp_view.v_vz_dispo_status_spr_zu_1 v01

GROUP BY v01.vz_dispo_status_id, v01.mandant_id;