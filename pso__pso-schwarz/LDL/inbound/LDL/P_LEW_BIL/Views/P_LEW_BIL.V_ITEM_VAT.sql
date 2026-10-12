CREATE OR REPLACE VIEW P_LEW_BIL.V_ITEM_VAT(
    CLIENT_ID
  , ITEM_SID
  , ITEM_NAME
  , ORIG_ITEM_NR
  , DAT_CALENDAR
  , VAT_ID
  , VAT_VALUE
  , VAT_DESCR
  , DWH_ACTUAL_FG
) AS
SELECT i.client_id
    , i.item_sid
    , i.item_name
    , COALESCE(i.src_orig_item_nr, i.config_item_cd) AS orig_item_nr
    , cal.cal_dt AS dat_calendar
    , CASE
        WHEN cal.cal_dt NOT BETWEEN cli.migration_dat_valid_from AND cli.migration_dat_valid_to
        AND wrwvv_wawi.vat_id IS NOT NULL THEN   wrwvv_wawi.vat_id
        WHEN wrwvv_elwis.vat_id IS NOT NULL THEN wrwvv_elwis.vat_id
        ELSE                                     wrwvv_wawi.vat_id
      END AS vat_id
    , CASE
        WHEN cal.cal_dt NOT BETWEEN cli.migration_dat_valid_from AND cli.migration_dat_valid_to
        AND wrwvv_wawi.vat_id IS NOT NULL THEN   wrwvv_wawi.pct_vat
        WHEN wrwvv_elwis.vat_id IS NOT NULL THEN wrwvv_elwis.pct_vat
        ELSE                                     wrwvv_wawi.pct_vat
      END AS vat_value
    , CASE
        WHEN cal.cal_dt NOT BETWEEN cli.migration_dat_valid_from AND cli.migration_dat_valid_to
        AND wrwvv_wawi.vat_id IS NOT NULL THEN   wrwvv_wawi.vat_desc
        WHEN wrwvv_elwis.vat_id IS NOT NULL THEN wrwvv_elwis.vat_desc
        ELSE                                     wrwvv_wawi.vat_desc
      END AS vat_descr
    , CASE WHEN CURRENT_DATE = cal.cal_dt
        THEN 1
        ELSE 0
    END AS dwh_actual_fg
FROM p_lew_core_ac.v_item AS i
    -- Kartesisch den Kalender multiplizieren
    INNER JOIN p_lew_core_ac.v_cal_calendarday AS cal
        ON cal.cal_dt BETWEEN DATE'2010-03-01' AND CURRENT_DATE
-- Martin Murtenthaler: Migration time infos 
INNER JOIN p_lew_core_ac.v_client_migration_per AS cli
ON cli.client_id=i.client_id
    -- COUNTRY_CODE des Clients ermitteln --> Wird für die Priorisierung der möglichen n Steuersätze zu einem Artikel benötigt
    INNER JOIN p_lew_core_ac.v_client AS c
        ON c.client_id = i.client_id
    -- Elwis: Erster Zugriff für MWST Inland (nur VAT Schlüssel) --> 1. Prio
    LEFT OUTER JOIN p_lew_core_ac.v_item_tax_country_hist AS tax_home_cntry
        ON tax_home_cntry.client_id = i.client_id
        AND tax_home_cntry.item_sid = i.item_sid
        -- Für Nordirland (CLIENT_ID) wird als COUNTRY_CD statisch "GB" statt "NI" gesetzt, da dies aktuell nicht dynamisch sauber abgebildet werden kann (CLIENT <-> politisches Country Zuordnung fehlt).
        -- Bei Nordirland ist diese statische Regel notwendig, da sonst die Regel zur Priorisierung nicht funktioniert und in manchen Fällen deutsche Steuersätze für Nordirland gezogen werden
        -- Sobald im DWH die Zuordnung CLIENT <-> Politisches Land existiert, kann die statische Regel zu einer dynamischen geändert werden
        AND tax_home_cntry.country_pol_cd = CASE WHEN c.client_id = 21 THEN 'GB' ELSE c.country_cd END
        AND cal.cal_dt BETWEEN tax_home_cntry.dwh_valid_from AND tax_home_cntry.dwh_valid_to
        AND tax_home_cntry.tax_class_cd <> 'X'
        AND tax_home_cntry.deleted_fg = 0
    -- Elwis: Zweiter Zugriff für MWST mit Auslandbezug (nur VAT Schlüssel) --> 2. Prio: Kein Steuersatz für das politische Land erfasst (kann auftreten, wenn wohl z.B. Stammdaten eines Clients für einen anderen Client kopiert werden)
    LEFT OUTER JOIN p_lew_core_ac.v_item_tax_country_hist AS tax_foreign_cntry
        ON tax_foreign_cntry.client_id = i.client_id
        AND tax_foreign_cntry.item_sid = i.item_sid
        AND tax_foreign_cntry.country_pol_cd <> CASE WHEN c.client_id = 21 THEN 'GB' ELSE c.country_cd END
        AND cal.cal_dt BETWEEN tax_foreign_cntry.dwh_valid_from AND tax_foreign_cntry.dwh_valid_to
        AND tax_foreign_cntry.tax_class_cd <> 'X'
        AND tax_foreign_cntry.deleted_fg = 0
        AND tax_home_cntry.item_sid IS NULL -- Inlandsteuersatz existiert nicht
      -- Falls es Mehrfachtreffer geben sollte, dann nur den Eintrag mit der höchsten Land ID berücksichtigen (willkürliche Definition)
      -- umgedreht auf niedrigste, damit in Nordirland GB vor IE zieht, das wurde so gewuenscht
    LEFT OUTER JOIN p_lew_core_ac.v_item_tax_country_hist AS tax_foreign_cntry_rank
        ON tax_foreign_cntry_rank.client_id = tax_foreign_cntry.client_id
        AND tax_foreign_cntry_rank.item_sid = tax_foreign_cntry.item_sid
        AND tax_foreign_cntry_rank.country_pol_cd < tax_foreign_cntry.country_pol_cd -- Regel zur Priorisierung
        AND cal.cal_dt BETWEEN tax_foreign_cntry_rank.dwh_valid_from AND tax_foreign_cntry_rank.dwh_valid_to
        AND tax_foreign_cntry_rank.tax_class_cd <> 'X'
        AND tax_foreign_cntry_rank.deleted_fg = 0
    -- Mappen Steuerklasse auf Vat ID (nur Elwis Länder, weil es nur dafuer ein Mapping gibt.
    LEFT OUTER JOIN p_lew_core_ac.v_map_mis_tax_class AS map_mtc
        ON map_mtc.client_id = COALESCE(tax_home_cntry.client_id, tax_foreign_cntry.client_id)
        AND map_mtc.tax_class_cd = COALESCE(tax_home_cntry.tax_class_cd, tax_foreign_cntry.tax_class_cd)
    -- Ermittlung Artikel aus Wawi fuer Lookup Wawi
    LEFT OUTER JOIN p_lew_core_ac.v_wawi_itm_item AS wii
        ON wii.client_id = i.client_id
        AND wii.item_sid = i.item_sid
        AND cal.cal_dt BETWEEN wii.dat_rec_start AND wii.dat_rec_end
    LEFT OUTER JOIN p_lew_core_ac.v_wawi_ref_wawi_vat_values AS wrwvv_elwis
        ON wrwvv_elwis.client_id = map_mtc.client_id
        AND wrwvv_elwis.vat_id = map_mtc.mis_vat_id
        AND cal.cal_dt BETWEEN wrwvv_elwis.dat_rec_start AND wrwvv_elwis.dat_rec_end
    LEFT OUTER JOIN p_lew_core_ac.v_wawi_ref_wawi_vat_values AS wrwvv_wawi
        ON wrwvv_wawi.client_id = wii.client_id
        AND wrwvv_wawi.vat_id = wii.vat_id
        AND cal.cal_dt BETWEEN wrwvv_wawi.dat_rec_start AND wrwvv_wawi.dat_rec_end
    -- 2. WAWI-Tabelle mit Steuersätzen not needed at the moment
    /*LEFT OUTER JOIN  p_lew_core_ac.v_wawi_ref_vat AS wrv
        ON wrv.client_id = i.client_id
        AND wrv.vat_id = CASE
                           -- Martin Murtenthaler: If date within WAWI time, then infos out of WAWI table
                           WHEN cal.cal_dt NOT BETWEEN cli.migration_dat_valid_from AND cli.migration_dat_valid_to AND wii.vat_id=wrv.vat_id THEN wii.vat_id
                           WHEN map_mtc.mis_vat_id=wrv.vat_id THEN map_mtc.mis_vat_id
                           -- Martin Murtenthaler: If map_mtc does not work
                           ELSE wii.vat_id
                         END
        AND wrv.language_id = 7 -- Duplikate aufgrund der Mehrsprachigkeit verhindern, weshalb auf die Stiftungssprache gefiltert wird
        AND cal.cal_dt BETWEEN wrv.dat_rec_start AND wrv.dat_rec_end
        AND wrv.client_id NOT IN (SELECT DISTINCT client_id FROM p_lew_core_ac.v_wawi_ref_wawi_vat_values WHERE vat_id > 0)*/ -- ???
-- tax_foreign_cntry_rank.client_id muss immer null sein. Entweder um Mehrfachtreffer zu verhindern (dann wird nur der Steuersatz aus dem Inland oder der höchste, priorisierte Auslandssteuersatz genommen) oder weil der Satz aus WaWI kommt
WHERE tax_foreign_cntry_rank.client_id IS NULL
AND COALESCE(wrwvv_elwis.vat_id, wrwvv_wawi.vat_id) IS NOT NULL;