CREATE OR REPLACE VIEW dbp_msi_view_log.mv_lagerbew_2 -- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
(
 beleg_user_name
,dat_beleg
,dat_buch
,dat_erfasst
,kj
,lagerbew_beleg_id
,mandant_id
,ref_lagerbew_beleg_id
,vorgangsart_id
,belegkopftext
,ref_lagerbew_beleg_id_num
,kj_lief_beleg
)
AS
SELECT
v01.beleg_user_name,
v01.dat_beleg,
v01.dat_buch,
v01.dat_erfasst,
v01.kj,
v01.lagerbew_beleg_id,
v01.mandant_id,
v01.ref_lagerbew_beleg_id,
v01.vorgangsart_id,
v01.belegkopftext,
v01.ref_lagerbew_beleg_id_num,
v02.kj
FROM dbp_view.v_lagerbew_2 v01

LEFT JOIN dbp_view.v_besch_lief_2 v02
ON v01.ref_lagerbew_beleg_id_num = v02.lief_beleg_id
AND v01.mandant_id = v02.mandant_id
AND Extract(YEAR From v01.dat_buch) BETWEEN v02.kj - 1 AND v02.kj + 1;
