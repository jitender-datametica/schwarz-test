CREATE OR REPLACE VIEW dbp_msi_view_log.mv_art_gp_zu_per_2  -- 26.02.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
(
 art_id
,gp_id
,mandant_id
,herst_id
,gp_art_id
,dat_von
,dat_bis
)
AS
SELECT
v01.art_id,
v01.gp_id,
v01.mandant_id,
v01.herst_id,
v01.gp_art_id,
Max(v01.dat_von),
Max(v01.dat_bis)
FROM dbp_view.v_art_gp_zu_per_2 v01
WHERE dat_bis = '9999-12-31'
GROUP BY v01.art_id
        ,v01.gp_id
        ,v01.mandant_id
        ,v01.herst_id
        ,v01.gp_art_id;
