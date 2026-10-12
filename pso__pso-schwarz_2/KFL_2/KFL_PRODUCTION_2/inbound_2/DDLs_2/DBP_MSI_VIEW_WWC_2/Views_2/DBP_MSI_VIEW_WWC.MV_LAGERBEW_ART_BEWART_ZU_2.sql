CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_LAGERBEW_ART_BEWART_ZU_2
---20140512 kkaiser initial für # 595556, geht 1.1 auf Aggregat lagerbew_art_bewart_zu_2
(
art_id
,mandant_id
,lager_bewart_id
,wup_id
,nb_id
,dat_buch_first
,dat_buch_last
,dat_erfasst_first
,dat_erfasst_last
)
AS
   SELECT
   art_id, mandant_id, lager_bewart_id, wup_id, nb_id, dat_buch_first, dat_buch_last, dat_erfasst_first, dat_erfasst_last

   FROM dbp_view.v_lagerbew_art_bewart_zu_2 v01

;