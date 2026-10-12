CREATE OR REPLACE VIEW dbp_msi_view_log.mv_art_vorschlagswert_1
AS
-- 30.03.2021, SPEC0107644, AP0081632 , nwag2310, initial
SELECT
v01.mandant_id,
v01.art_id,
v01.ausg_menge_einh_id,
v01.paletten_faktor_einh_id,
v01.sortimentslistenart_id,
v01.zl_kolli_menge_einh_id,
v01.lage_faktor_einh_id,
v01.auspack_fg
FROM dbp_view.v_art_vorschlagswert_per_1 v01
WHERE v01.dat_bis= to_date('9999-12-31', 'YYYY-MM_1-DD');