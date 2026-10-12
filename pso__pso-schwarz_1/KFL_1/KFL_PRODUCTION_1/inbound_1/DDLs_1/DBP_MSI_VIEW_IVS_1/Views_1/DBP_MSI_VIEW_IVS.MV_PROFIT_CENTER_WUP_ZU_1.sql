CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_PROFIT_CENTER_WUP_ZU_1
            (
            krk_id,
            mandant_id,
            pc_id,
            system_id,
            wup_id,
            nb_id,
            eroeffnungsdatum,
            schliessungsdatum,
            startdate,
            expansionsflag
            )
            AS
               SELECT
              p.krk_id,
               p.mandant_id,
               p.pc_id,
               p.system_id,
               p.wup_id,
               p.nb_id,
               w.dat_von,
               w.dat_bis,
               h.startdate,
               CASE
               WHEN w.dat_von > h.startdate THEN 1
               WHEN w.dat_bis < CURRENT_DATE THEN 2
               WHEN w.dat_von IS NULL THEN 3
               ELSE 0
               END AS expansionsflag

               FROM dbp_view.v_profit_center_1 p
               LEFT OUTER JOIN dbp_view.v_wup_1 w
               ON
               p.wup_id=w.wup_id
               AND
               p.mandant_id=w.mandant_id
               AND
               p.nb_id=w.nb_id
               INNER JOIN dbp_msi_view_ivs.mv_expansionshilfe_1 h
               ON
               h.krk_id=p.krk_id;