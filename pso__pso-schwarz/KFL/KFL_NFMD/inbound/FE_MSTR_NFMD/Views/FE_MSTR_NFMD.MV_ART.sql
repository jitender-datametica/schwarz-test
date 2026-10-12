CREATE OR REPLACE VIEW FE_MSTR_NFMD.MV_ART  
(
 art_id
,mandant_id
,mwst_id
,land_id
,region_id
,kl_art_id
,dat_von
,dat_bis
,loesch_id
,mutter_wb_id
,display_fg
,posten_KZ_SAP
)
AS
SELECT
v02.art_id,
v02.mandant_id,
v02.mwst_id,
v02.land_id,
v02.region_id,
v02.kl_art_id,
v02.dat_von,
v02.dat_bis,
v02.loesch_id,
v02.mutter_wb_id,
CASE WHEN v02.artikeltyp_id = 12 THEN 'X' ELSE ' ' END AS display_fg, 
v02.posten_KZ_SAP
FROM CORE.SRC_TERADATA_MASTER_DATA_ART v02;