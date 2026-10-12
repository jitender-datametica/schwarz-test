CREATE OR REPLACE VIEW FE_MSTR_NFMD.MV_WUP 
(
  mandant_id
, wup_id
, wup_name
, nb_id
, dat_von
, dat_bis
, dat_eroeffnung
, wup_plz
, breitengrad
, laengengrad
, uebernahme_von
, vs_id
)
AS
SELECT DISTINCT 
v01.mandant_id,
v01.wup_id,
v01.WUP_NAME_E as wup_name,
v01.nb_id,
v01.dat_von,
v01.dat_bis,
v01.dat_eroeffnung,
v01.wup_plz,
v01.breitengrad,
v01.laengengrad,
v01.uebernahme_von,
v01.vs_id
FROM CORE.SRC_TERADATA_MASTER_DATA_WUP v01
-- 0 -> only market 
WHERE  v01.nb_id = 0;