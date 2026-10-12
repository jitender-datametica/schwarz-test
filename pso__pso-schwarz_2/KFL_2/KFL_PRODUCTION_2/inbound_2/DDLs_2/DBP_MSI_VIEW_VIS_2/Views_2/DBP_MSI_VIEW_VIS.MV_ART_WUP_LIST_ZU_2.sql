CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ART_WUP_LIST_ZU_2 as
   SELECT
   mandant_id, wup_id, nb_id, art_id, bezugsweg_id, kdis, listung_id, CASE WHEN listung_id = 1
   THEN (CASE WHEN bezugsweg_id = 1
   THEN (CASE WHEN KDIS = 0
   THEN 1
   ELSE 5
   END)
   WHEN bezugsweg_id = 4
   THEN (CASE WHEN KDIS = 0
   THEN 4
   ELSE 8
   END)
   ELSE 0
   END)
   ELSE 0
   END                         AS listung_markt
   FROM dbp_view.v_art_wup_zu_per_2
   WHERE dat_bis = '9999-12-31'
   -- 20100330 Filterung der IWT Betriebe
   AND nb_id <> 99
;