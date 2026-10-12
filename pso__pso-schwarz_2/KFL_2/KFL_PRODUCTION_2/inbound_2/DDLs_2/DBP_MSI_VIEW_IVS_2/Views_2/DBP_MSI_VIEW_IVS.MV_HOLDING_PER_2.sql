CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_HOLDING_PER_2 as

            -- Lookup Stammdaten Holding (Gruppierung von Konzessionaer)
            -- Teilmenge aus Konzessionaer
            -- 2011KW50 Update Verbundkennz1, intern_fg entfernt
            -- 2012KW07 Einschraenkung auf echte Holding + Dummy_2

            SELECT
            v01.mandant_id,
            v01.konzessionaer_id  AS holding_id,
            CASE WHEN konzessionaer_id = '0' THEN 'keine Holding' ELSE v01.konzessionaer_name END  AS holding_name,
            CASE WHEN konzessionaer_id = '0' THEN 0 ELSE 1 END::BYTEINT AS holding_fg,
            v01.dat_von,
            v01.dat_bis,
            v01.land_id,
            v01.konzessionaer_plz          AS holding_plz,
            v01.konzessionaer_ort          AS holding_ort,
            v01.konzessionaer_strasse      AS holding_strasse,
            v01.konzessionaer_rechtsform   AS holding_rechtsform,
            v01.dat_insolvenz_eintritt     AS holding_dat_insolvenz,
            v01.konzessionaer_topmieter_fg AS holding_topmieter_fg,
            COALESCE(v01.konzessionaer_branche_id, '145') AS holding_branche_id
           FROM dbp_view.v_ivs_konzessionaer_per_2 v01

            JOIN
            ( -- Join/Subselect zur Ermittlung Holdings
            SELECT
            mandant_id,
            konzessionaer_holding_id
           FROM dbp_view.v_ivs_konzessionaer_per_2
           WHERE konzessionaer_holding_id <> konzessionaer_gruppe_id
           AND dat_bis = '9999-12-31'
           GROUP BY
           mandant_id
           , konzessionaer_holding_id
           ) v02
            ON   v01.mandant_id = v02.mandant_id
            AND  v01.konzessionaer_id = v02.konzessionaer_holding_id

            WHERE v01.dat_bis = '9999-12-31';