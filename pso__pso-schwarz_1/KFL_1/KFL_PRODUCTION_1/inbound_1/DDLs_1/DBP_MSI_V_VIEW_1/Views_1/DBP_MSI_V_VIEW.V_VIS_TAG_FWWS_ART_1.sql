CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_VIS_TAG_FWWS_ART_1
AS
SELECT
 mandant_id
,wup_id
,dat
,nb_id
,art_id
,dispomerkmal
,disponent_id
,artikel_exc209_fg
,artikel_exc214_fg
,tagesartikel_fg
,bestandsartikel_fg
,autodispo_fg
,alle_art_o_kdis_fg
,alle_art_fg
,autodispo_fg_12
,bezugsweg_id
FROM dbp_msi_data.vis_tag_fwws_art_1;