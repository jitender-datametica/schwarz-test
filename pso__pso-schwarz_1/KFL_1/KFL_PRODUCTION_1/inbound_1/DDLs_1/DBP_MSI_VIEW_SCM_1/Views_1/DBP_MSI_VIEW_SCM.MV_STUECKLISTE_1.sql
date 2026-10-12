CREATE OR REPLACE VIEW dbp_msi_view_scm.mv_stueckliste_1
-- 20.07.2021 sanadze (Mayko): SPEC0106469 erstellt auf Snowflake
AS
SELECT
	stko.mandant_id
	, stko.stueckliste_id
	, stko.dat_von as dat_von
	, stko.dat_bis as dat_bis
	, stko.art_id as art_id_kopf
	, stko.stueckliste_verwendung_id
	, stpo.stueckliste_pos_id
	, stpo.dat_von as dat_von_pos
	, stpo.dat_bis as dat_bis_pos
	, stpo.art_id as art_id_komponente
	, stpo.stueckliste_typ_id
	, stpo.komponentenmenge
	, stpo.komponentenmenge_einh_id
FROM dbp_view.v_stueckliste_1 stko_1
JOIN dbp_view.v_stueckliste_det_1 stpo_1
	ON (stko.mandant_id = stpo.mandant_id
		AND stko.stueckliste_id = stpo.stueckliste_id)
WHERE stko.dat_bis = '9999-12-31'
	AND stpo.dat_bis = '9999-12-31';