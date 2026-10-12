CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_FLAECHE_HIST_2
     (

     mandant_id
     ,flaeche_id
     ,dat_von
     ,dat_bis
     ,flaeche_status_id
     ,immo_objekt_id
     ,gebaeude_id
     ,etage
     ,nutzung_id
     ,flaeche_groesse
     ,flaecheart_id
     ,dat_existiert_seit
     ,dat_existiert_bis
     )
     AS
        SELECT
        fl.mandant_id,
        fl.flaeche_id,
        dat_von,
        dat_bis,
        flaeche_status_id_ AS flaeche_status_id,
        immo_objekt_id,
        gebaeude_id,
        etage,
        nutzung_id,
        flaeche_groesse,
        flaecheart_id,
        dat_existiert_seit,
        dat_existiert_bis

        FROM dbp_view.v_ivs_flaeche_per_2 fl
        INNER JOIN
        (
        SELECT
        mandant_id,
        flaeche_id,
        MAX(flaeche_status_id) AS flaeche_status_id_
        FROM dbp_view.v_ivs_miet_fl_stat_zu_per_2
        WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis
        GROUP BY 1,2
        ) mfszp
        ON mfszp.mandant_id = fl.mandant_id
        AND mfszp.flaeche_id = fl.flaeche_id

        WHERE fl.dat_bis = '9999-12-31'


---> Geändert auf WHERE fl.dat_bis = '9999-12-31', da MAX dat_von entspricht 31.12.9999 bei  dat_bis
;