CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_KER_WUP (
      MANDANT_ID,
      NB_ID,
      WUP_ID,
      WRG_ID,
      KJMO,
      KER_LV,
      KER_ID,
      VVJ_JAHR,
      VJ_JAHR,
      PLAN_JAHR,
      VJ_KUM,
      IST_KUM,
      PLAN_KUM,
      VJ,
      IST,
      PLAN,
      UMS_VVJ_JAHR,
      UMS_VJ_JAHR,
      UMS_PLAN_JAHR,
      UMS_VJ_KUM,
      UMS_IST_KUM,
      UMS_PLAN_KUM,
      UMS_VJ,
      UMS_IST,
      UMS_PLAN
) AS
   -- FAKT-AGGREGAT KER Kostenrechnung Betrag KA pro Monat/GJ - Markt
   -- Datenumfang: 1 GJ*
   -- 2011KW28 INITIAL
   -- 2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]

SELECT
      v01.mandant_id
      , v01.nb_id
      , wup.aktuell_wup_id AS wup_id
      , v01.wrg_id
      , v01.kjmo
      , v01.ker_lv
      , v01.ker_id
      , v01.vvj_jahr
      , v01.vj_jahr
      , v01.plan_jahr
      , v01.vj_kum
      , v01.ist_kum
      , v01.plan_kum
      , v01.vj
      , v01.ist
      , v01.plan
      , v01.ums_vvj_jahr
      , v01.ums_vj_jahr
      , v01.ums_plan_jahr
      , v01.ums_vj_kum
      , v01.ums_ist_kum
      , v01.ums_plan_kum
      , v01.ums_vj
      , v01.ums_ist
      , v01.ums_plan
FROM dbp_msi_v_view.v_vis_monat_ker_wup  v01
   
INNER JOIN dbp_view.v_wup wup
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
;