-- LEFT JOIN auf leist_einzelauswertung_wup_2, zusätzlich WHERE Bedingung am Ende

-- 05.10.2016, AP0003754, srom0404, Erweiterung sap_id, gruppe_id

-- 03.04.2018, INC0179339, srom0404, doppelte Einträge, wenn ein User auf Grund der Berechtigungsvergabe 0 und 1 bei leist_auswerteberechtigt_fg hat

-- 16.11.2016, AP0003754, SPEC0005757, srom0404, Erweiterung um zusätzliche Sicherheitsview

-- nfis: Vermeidung von doppelten Einträgen von anonymisierten Usern

-- 14.12.2016, srom0404 Extern sollen immer sichtbar sein, auch wenn nicht in Steuertabelle vorhanden

-- Das 'Eigen' Konstrukt wird nicht mehr benötigt

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_transport_leistung_sum_2(USERID STRING) AS -- externe MA dürfen immer auf Einzelebene ausgewertet werden

-- Extern sollen immer sichtbar sein, auch wenn nicht in Steuertabelle vorhanden (entsprechende WHERE Bedingung)

-- Session Variable statt Akt_MSI_User_2 verwenden
 -- ,leist_empfaenger_sap_id
 -- NC0179339, doppelte Einträge

-- ,leist_auswerteberechtigt_fg

-- Der CROSS JOIN ist ohne leist_empfaenger_sap_id, da hier nur der aktuelle User vorhanden ist und die Freigabe auf VZ Ebene erfolgt

SELECT V01.lagernummer_id,
 V01.mandant_id,
 V01.von_lagertyp_id,
 V01.nach_lagertyp_id,
 V01.wup_id,
 V01.nb_id -- um weiterhin einen CROSS JOIN auf leist_empfaenger_sap_id zu ermöglichen

 -- siehe dazu auch View mv_l_leist_empfaenger. Dort wird ein 'Eigen' Satz angehängt,

 -- ,CASE WHEN v02.leist_einzelauswertung_fg = 1 AND v04.ext_ma_fg = 0 THEN v01.leist_empfaenger_sap_id

 -- WHEN v02.leist_einzelauswertung_fg = 0 AND v04.ext_ma_fg = 0 THEN 'Eigen'
 -- ELSE v01.leist_empfaenger_sap_id

 -- END AS leist_empfaenger_sap_id
,
  CASE
  WHEN V02.leist_einzelauswertung_fg = 1 AND v03.leist_auswerteberechtigt_fg = 1 AND V01.ext_ma_fg = 0 OR V01.ext_ma_fg
    = 1
  THEN V01.leist_empfaenger_sap_id
  -- In mv_l_leist_empfaenger_2 werden 'Eigen' Sätze generiert, damit diese dort einen CROSS JOIN-Partner finden

  -- Berichtsfilter (Attribut 'Leistungsempfänger Einzel') auf ext_ma_fg = 0 und leist_empfaenger_sap_id <> 'Eigen'

  -- zeigt dann im Bericht keine Daten an, wenn keine Einzelberechtigung besteht.

  ELSE 'Eigen'
  END AS leist_empfaenger_sap_id,
 V01.leist_empfaenger_gruppe_id,
 V01.dat_leistung,
 V01.transport_gv_id,
 V01.gp_id,
 V01.menge_kolli,
 V01.zeit_sekunden,
 V01.zeit_ruest_sekunden,
 V01.zeit_pause_sekunden,
 V01.anzahl_transportauftrag,
 V01.anzahl_versandblock,
 V01.anzahl_ruestzeit,
 V01.anzahl_pause
FROM kfl_production_dbp_msi_view3.tbl_mv_transport_leistung_sum_2 AS V01
 LEFT JOIN kfl_production_dbp_security.leist_einzelauswertung_wup_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id
     = V02.wup_id AND V01.nb_id = V02.nb_id
   -- LEFT JOIN, Ist ein User nicht eingetragen, sieht er durch obiges CASE keine leist_empfaenger_sap_id, sondern nur NULL

   -- Freigabe erfolgt auf Ebene VZ / Leistungsempfaenger. Lagernummer nicht erforderlich

   -- Nur für den angemeldeten User. Es werden für seine VZ / Freigabe Zuordnung die Daten entsprechend auf Einzel oder NULL dargestellt

   -- Alle anderen VZ (für die er nicht zugeordnet ist) werden auf NULL dargestellt. NULL ist in Lookup nicht vorhanden und somit sieht ein nicht berechtigter User keine Daten

   -- Über den MSI Sicherheitsfilter (kommt im Bericht dazu, wird dann nur sein Land_2, VZ oder GP_2 herausgefiltert.

 LEFT JOIN (SELECT mandant_id,
   wup_id,
   nb_id -- ,v030.leist_empfaenger_sap_id
 -- NC0179339, doppelte Einträge
,
   MAX(leist_auswerteberechtigt_fg) AS leist_auswerteberechtigt_fg
  FROM kfl_production_dbp_security.leist_empfaenger_ldap_zu_2 AS V030
  WHERE ma_ldap = USERID
  GROUP BY mandant_id,
   wup_id,
   nb_id) AS v03 ON V01.mandant_id = v03.mandant_id AND V01.wup_id = v03.wup_id AND V01.nb_id = v03.nb_id
WHERE V02.leist_einzelauswertung_fg IS NOT NULL
 OR V01.ext_ma_fg = 1;