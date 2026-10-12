CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_FLAECHE_STATUS_HISTORIE_1 as
         -- 2009-06-15
         -- FAKT-VIEW Flaeche Status_1
         -- aktuell + Historie vor 30 bzw 365 Tagen
         -- 2009KW27 Anpassung Logik + Feldformate
         -- 2011KW3838 umgelenkt flaeche_status_id aus dbp_view.v_miet_fl_stat_zu_per
         -- 2011-11-29 Erweiterung Mietvertrag, anpassung Historienermittlung

         SELECT
         fl000.mandant_id,
         fl000.flaeche_id,
         fl000.mietvertrag_id,
         CASE WHEN COALESCE(fl000.fl_status_id_aktuell,'-')::VARCHAR(1) <> COALESCE(fl030.fl_status_id_minus_30_tage,'-')::VARCHAR(1) THEN 1
         ELSE 0
         END::BYTEINT AS fl_status_fg,
         COALESCE(fl000.fl_status_id_aktuell,'-')::VARCHAR(1) AS fl_status_id_aktuell,
         COALESCE(fl030.fl_status_id_minus_30_tage,'-')::VARCHAR(1) AS fl_status_id_minus_30_tage,
         COALESCE(fl365.fl_status_id_minus_365_tage,'-')::VARCHAR(1) AS fl_status_id_minus_365_tage
         FROM
         (
         SELECT
         fl.mandant_id,
         fl.flaeche_id,
         mfszp.mietvertrag_id,
         CASE WHEN CURRENT_DATE BETWEEN fl.dat_existiert_seit AND fl.dat_existiert_bis
         THEN TRIM(mfszp.flaeche_status_id_)
         WHEN fl.dat_existiert_seit BETWEEN CURRENT_DATE AND fl.dat_existiert_bis
         THEN TRIM(mfszp.flaeche_status_id_)
         ELSE '-'
         END::VARCHAR(1) AS fl_status_id_aktuell
         FROM dbp_view.v_ivs_flaeche_per_1 fl
         INNER JOIN
         (
         SELECT
         mfzp.mandant_id,
         mfzp.flaeche_id,
         mfzp.mietvertrag_id,
         mfzp.flaeche_status_id AS flaeche_status_id_
        FROM dbp_view.v_ivs_miet_fl_stat_zu_per_1 mfzp

         WHERE CURRENT_DATE BETWEEN mfzp.dat_von AND mfzp.dat_bis
         ) mfszp
         ON mfszp.mandant_id = fl.mandant_id
         AND mfszp.flaeche_id = fl.flaeche_id

         WHERE fl.dat_bis = '9999-12-31'
         ) fl000
         LEFT OUTER JOIN
         (
         SELECT
         fl.mandant_id,
         fl.flaeche_id,
         mfszp.mietvertrag_id,
         CASE WHEN (CURRENT_DATE -30) BETWEEN fl.dat_existiert_seit AND fl.dat_existiert_bis
         THEN TRIM(mfszp.flaeche_status_id_)
         ELSE '-'
         END::VARCHAR(1)  fl_status_id_minus_30_tage
         FROM dbp_view.v_ivs_flaeche_per_1 fl
         INNER JOIN
         (
         SELECT
         mfzp.mandant_id,
         mfzp.flaeche_id,
         mfzp.mietvertrag_id,
         mfzp.flaeche_status_id AS flaeche_status_id_
        FROM dbp_view.v_ivs_miet_fl_stat_zu_per_1 mfzp

         WHERE (CURRENT_DATE -30) BETWEEN mfzp.dat_von AND mfzp.dat_bis
         ) mfszp
         ON mfszp.mandant_id = fl.mandant_id
         AND mfszp.flaeche_id = fl.flaeche_id

         WHERE (CURRENT_DATE - 30) BETWEEN fl.dat_von AND fl.dat_bis
         ) fl030
         ON fl000.mandant_id = fl030.mandant_id
         AND fl000.flaeche_id = fl030.flaeche_id
         AND fl000.mietvertrag_id = fl030.mietvertrag_id
         LEFT OUTER JOIN
         (
         SELECT
         fl.mandant_id,
         fl.flaeche_id,
         mfszp.mietvertrag_id,
         CASE WHEN (CURRENT_DATE -365) BETWEEN fl.dat_existiert_seit AND fl.dat_existiert_bis
         THEN TRIM(mfszp.flaeche_status_id_)
         ELSE '-'
         END::VARCHAR(1)  fl_status_id_minus_365_tage
         FROM dbp_view.v_ivs_flaeche_per_1 fl
         INNER JOIN
         (
         SELECT
         mfzp.mandant_id,
         mfzp.flaeche_id,
         mfzp.mietvertrag_id,
         mfzp.flaeche_status_id AS flaeche_status_id_
        FROM dbp_view.v_ivs_miet_fl_stat_zu_per_1 mfzp
         WHERE (CURRENT_DATE -365) BETWEEN mfzp.dat_von AND mfzp.dat_bis
         ) mfszp
         ON mfszp.mandant_id = fl.mandant_id
         AND mfszp.flaeche_id = fl.flaeche_id

         WHERE (CURRENT_DATE - 365) BETWEEN fl.dat_von AND fl.dat_bis
         ) fl365
         ON fl000.mandant_id = fl365.mandant_id
         AND fl000.flaeche_id = fl365.flaeche_id
         AND fl000.mietvertrag_id = fl365.mietvertrag_id
;