CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_zahlungsziel (mandant_id, zahlungsziel, tagesstufe1,
prozentstufe1, tagesstufe2, prozentstufe2, tagesstufe3) AS SELECT mandant_id,
 zahlungsziel_id AS zahlungsziel,
 zahlungsziel_1_tage AS tagesstufe1,
 zahlungsziel_1_prozent AS prozentstufe1,
 zahlungsziel_2_tage AS tagesstufe2,
 zahlungsziel_2_prozent AS prozentstufe2,
 zahlungsziel_3_tage AS tagesstufe3
FROM kfl_production_dbp_view.v_l_zahlungsziel;