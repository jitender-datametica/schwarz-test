CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUP_VIS_WETTBEWERBER_2
    AS
        -- STAMMDATEN - Eroeffnung (max 3) Wettbewerber pro wup_2
        -- projection on wup_2, dummy_2 values
        -- 2020.03.05 ssch0611 : Initial

       SELECT
         ww.mandant_id, ww.nb_id, ww.wup_id, ww.dat_eroeffnung, Coalesce (wb.wb_rang, 0)   AS wb_rang -- Dummy_2
       , Coalesce (wb.wb_name, '')  AS wb_name -- Dummy_2
       , wb.wb_dat_von              AS wb_dat_von -- NULL
       FROM dbp_data.wup_2 ww
       LEFT JOIN dbp_data.vis_wettbewerber_2 wb
       ON wb.mandant_id = ww.mandant_id AND wb.wup_id = ww.wup_id

       WHERE ww.nb_id = 0
       AND ww.dat_von > CAST('1900-01-01' AS DATE) AND ww.dat_eroeffnung > CAST('1900-01-01' AS DATE);