CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_VIS_MONAT_UMS_KUNDE_WUP_1
         -- k.kaiser 20150310 - neu für Bericht 1.200, KL-Kunde uns Umsatz SBW
         -- aktuelles GJ
         (
         mandant_id
         , wrg_id
         , wrg_typ_id
         , wup_id
         , immo_objekt_id
         , gj
         , gj_vj_kz
         , kjmo_buchungsschluss
         , akt_buchungs_schluss
         , ums_netto
         , anz_kunde
         )
         AS
            SELECT
            alles.mandant_id,
            alles.wrg_id,
            alles.wrg_typ_id,
            alles.wup_id,
            immo.immo_objekt_id,
            alles.gj,
            alles.gj_vj_kz,
            alles.kjmo_buchungsschluss,
            0 AS akt_buchungs_schluss,
            SUM(  alles.ums_netto )      AS ums_netto,
            SUM(  alles.anz_kunde ) AS anz_kunde
           from
           (SELECT
           vis.mandant_id,
            vis.wrg_id,
            mwt.wrg_typ_id,
            vis.wup_id,
            mo.gj AS gj,
            0 AS gj_vj_kz,
            mo.kjmo_buchungsschluss,
            0 AS akt_buchungs_schluss,
            SUM(  vis.ums_netto )      AS ums_netto,
            SUM(  vis.anz_kunde ) AS anz_kunde
           FROM dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_1 vis
            join dbp_msi_view_ivs.mv_monat_3gj_1 mo
            ON (vis.kjmo between mo.kjmo_min and mo.gjmo_max)
            AND mo.gj_vj_kz = 0
            INNER JOIN dbp_view.v_mandant_wrg_typ_zu_1  mwt
            ON    vis.mandant_id = mwt.mandant_id
            and mwt.wrg_id = vis.wrg_id

            GROUP BY
            vis.mandant_id
            , vis.wrg_id
            , mwt.wrg_typ_id
            , vis.wup_id
            , mo.gj
            , gj_vj_kz
            , mo.kjmo_buchungsschluss
            , akt_buchungs_schluss

            UNION
            -- Vorjahres GJ
            SELECT
            vis.mandant_id,
            vis.wrg_id,
            mwt.wrg_typ_id,
            vis.wup_id,
            (mo.gj - 1) as gj,
            -1 AS gj_vj_kz,
            mo.kjmo_buchungsschluss,
            0 AS akt_buchungs_schluss,
            SUM(  vis.ums_netto_kvj )      AS ums_netto,
            SUM(  vis.anz_kunde_kvj ) AS anz_kunde

           FROM dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_1 vis
            join dbp_msi_view_ivs.mv_monat_3gj_1 mo
            ON (vis.kjmo between mo.kjmo_min and mo.kjmo_max)
            AND mo.gj_vj_kz = 0
            INNER JOIN dbp_view.v_mandant_wrg_typ_zu_1  mwt
            ON    vis.mandant_id = mwt.mandant_id
            and mwt.wrg_id = vis.wrg_id

            GROUP BY
            vis.mandant_id
            , vis.wrg_id
            , mwt.wrg_typ_id
            , vis.wup_id
            , mo.gj
            , gj_vj_kz
            , mo.kjmo_buchungsschluss
            , akt_buchungs_schluss

            UNION
            -- Vorvorjahres GJ
            SELECT
            vis.mandant_id,
            vis.wrg_id,
            mwt.wrg_typ_id,
            vis.wup_id,
            (mo.gj - 2) as gj,
            -2 AS gj_vj_kz,
            mo.kjmo_buchungsschluss,
            0 AS akt_buchungs_schluss,
            SUM(  vis.ums_netto_kvvj )      AS ums_netto,
            SUM(  vis.anz_kunde_kvvj ) AS anz_kunde

           FROM dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_1 vis
            join dbp_msi_view_ivs.mv_monat_3gj_1 mo
            ON (vis.kjmo between mo.kjmo_min and mo.kjmo_max)
            AND mo.gj_vj_kz = 0
            INNER JOIN dbp_view.v_mandant_wrg_typ_zu_1  mwt
            ON    vis.mandant_id = mwt.mandant_id
            and mwt.wrg_id = vis.wrg_id

            GROUP BY
            vis.mandant_id
            , vis.wrg_id
            , mwt.wrg_typ_id
            , vis.wup_id
            , mo.gj
            , gj_vj_kz
            , mo.kjmo_buchungsschluss
            , akt_buchungs_schluss

            UNION
            -- Vorvorjvorahres GJ
            SELECT
            vis.mandant_id,
            vis.wrg_id,
            mwt.wrg_typ_id,
            vis.wup_id,
            (mo.gj - 2) as gj,
            -3 AS gj_vj_kz,
            mo.kjmo_buchungsschluss,
            0 AS akt_buchungs_schluss,
            SUM(  vis.ums_netto_kvvj )  AS ums_netto,
            SUM(  vis.anz_kunde_kvvj ) AS anz_kunde

           FROM dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_1 vis
            join dbp_msi_view_ivs.mv_monat_3gj_1 mo
            ON (vis.kjmo between mo.kjmo_min and mo.kjmo_max)
            AND mo.gj_vj_kz = -1
            INNER JOIN dbp_view.v_mandant_wrg_typ_zu_1  mwt
            ON    vis.mandant_id = mwt.mandant_id
            and mwt.wrg_id = vis.wrg_id

            GROUP BY
            vis.mandant_id
            , vis.wrg_id
            , mwt.wrg_typ_id
            , vis.wup_id
            , mo.gj
            , gj_vj_kz
            , mo.kjmo_buchungsschluss
            , akt_buchungs_schluss
            ) ALLES
            LEFT OUTER JOIN
            (
            SELECT
            immo.mandant_id,
            immo.immo_objekt_id,
            immo.immo_objekt_bez
            FROM dbp_view.v_ivs_immo_objekt_per_1 immo
            where
            immo.dat_bis = '9999-12-31'
            Group BY 1,2,3
            )
            IMMO
            ON
            immo.mandant_id            = alles.mandant_id
            AND immo.immo_objekt_bez = alles.wup_id

            JOIN dbp_msi_view_ivs.mv_monat_1 m
            ON ALLES.kjmo_buchungsschluss = m.kjmo
            AND  m.akt_buchungs_schluss = 0


            GROUP BY
            ALLES.mandant_id
            , immo.immo_objekt_id
            , ALLES.wup_id
            , ALLES.wrg_id
            , ALLES.wrg_typ_id
            , ALLES.gj
            ,  ALLES.gj_vj_kz
            , ALLES.kjmo_buchungsschluss
            , m.akt_buchungs_schluss;