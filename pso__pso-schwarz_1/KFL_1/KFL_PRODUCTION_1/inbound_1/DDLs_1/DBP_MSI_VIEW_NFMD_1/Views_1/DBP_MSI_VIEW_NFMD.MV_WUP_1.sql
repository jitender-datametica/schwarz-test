CREATE OR REPLACE VIEW DBP_MSI_VIEW_NFMD.MV_WUP_1 AS
SELECT DISTINCT 
    v01.mandant_id,
    v01.wup_id,
    v01.WUP_NAME_E AS wup_name,
    v01.nb_id,
    v01.dat_von,
    v01.dat_bis,
    v01.dat_eroeffnung,
    v01.wup_plz,
    v01.breitengrad,
    v01.laengengrad,
    v01.uebernahme_von,
    v01.vs_id
FROM DBP_VIEW.V_WUP_1 v01
-- 0 -> only market 
WHERE  v01.nb_id = 0;