CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_WUP_KUNDE_WG_DISPORHYTHMUS_LFT_ZU_PER
-- 24.08.2017, AP0018098 - Disporhythmus, srom0404, initial
-- 16.03.2018, AP0018098 - Disporhythmus, srom0404, mandant_id_kunde
(
mandant_id
,wup_id
,nb_id
,mandant_id_kunde
,kunde_id
,wg_id
,arthiertyp_id
,sortimentslistenart_id
,terminierungsgruppe_1_id
,terminierungsgruppe_2_id
,terminierungsgruppe_3_id
,dat_von
,dat_bis
,auslieferungsgruppe_id
,disposition_rhythmus_ltf_id
)
AS
   SELECT
   v01.mandant_id, v01.wup_id, v01.nb_id, v01.mandant_id AS mandant_id_kunde -- nur temp. abgeleitet damit in MSI schon gebaut werden kann. Wenn Datenmodell angepasst wurde, auch hier dann richtig
   , v01.kunde_id, v01.wg_id, v01.arthiertyp_id, v01.sortimentslistenart_id, v01.terminierungsgruppe_1_id, v01.terminierungsgruppe_2_id, v01.terminierungsgruppe_3_id, v01.dat_von, v01.dat_bis, v01.auslieferungsgruppe_id, v01.disposition_rhythmus_ltf_id

   FROM dbp_view.v_wup_kunde_wg_disporhythmus_lft_zu_per v01
   WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis;