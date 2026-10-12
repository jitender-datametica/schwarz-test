CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_ZEITFENSTER_2 as
   SELECT
   mandant_id, zeitfenster_id, zeit_von, zeit_bis, report_zeit_von, report_zeit_bis
   FROM dbp_view.v_l_zeitfenster_2
;