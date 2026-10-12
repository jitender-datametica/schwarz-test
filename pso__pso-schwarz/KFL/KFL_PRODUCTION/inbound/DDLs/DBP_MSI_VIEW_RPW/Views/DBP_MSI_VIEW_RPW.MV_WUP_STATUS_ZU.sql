CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_WUP_STATUS_ZU
                         (
                            open_fg
                           ,open_bez
                         )
                         AS
                            SELECT
                               open_fg,
                            CASE
                                 WHEN open_fg=1 then 'Offen'
                                 WHEN open_fg=2 then 'Geloescht'
                                 WHEN open_fg=3 then 'Geplant'
                                 ELSE NULL
                               END AS open_bez
                            FROM dbp_msi_view_rpw.mv_wup
                            WHERE nb_id=0
                              AND open_fg <>0

                            GROUP BY 1
 ;