CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_tickets_topics AS SELECT id,
 subject,
 upload_date,
  CASE
  WHEN subject LIKE '%DES%'
  THEN 'DES'
  WHEN subject LIKE '%rite off%' OR subject LIKE '%bschreibung%' OR subject LIKE '%bschriften%' OR subject LIKE
    '%Write Off%'
  THEN 'Abschriften'
  WHEN subject LIKE '%Werbe%' OR subject LIKE '%werbe%' OR subject LIKE '%Advert%' OR subject LIKE '%advert%'
  THEN 'Werbeartikel/-termine'
  WHEN subject LIKE '%ieferant%'
  THEN 'Lieferant'
  WHEN subject LIKE '%torelist%'
  THEN 'MD-Storelist'
  WHEN subject LIKE '%langsam%' OR subject LIKE '%wird abgebrochen%' OR subject LIKE '%slow%'
  THEN 'Performance'
  WHEN subject LIKE '%utzungsgrad%'
  THEN 'PbV Nutzungsgrad'
  WHEN subject LIKE '%bersetzung%' OR subject LIKE '%ranslation%' OR subject LIKE '%prache%' OR subject LIKE '%anguage%'
    
  THEN 'Sprache/Übersetzung'
  WHEN subject LIKE '%nventur%' OR subject LIKE '%nventory%' OR subject LIKE '%nventories%'
  THEN 'Inventur'
  WHEN subject LIKE '%tückleistung%' OR subject LIKE '%tuckleistung%'
  THEN 'Stückleistung'
  WHEN subject LIKE '%STD%' OR subject LIKE '%rtikelbestände%' OR subject LIKE '%Bestand%' OR subject LIKE '%Bestände%'
     OR subject LIKE '%Stock%' OR subject LIKE '%stock%' OR subject LIKE '%bestände%'
  THEN 'STD Itemstock'
  WHEN subject LIKE '%alettenleistung%'
  THEN 'Palettenleistung'
  WHEN subject LIKE '%WE%' OR subject LIKE '%We-Kalk%' OR subject LIKE '%We Kalk%' OR subject LIKE '%WE_Kalk%' OR
            subject LIKE '%WE-Kalk%' OR subject LIKE '%WE Kalk%' OR subject LIKE '%WE-kalk%' OR subject LIKE '%WE kalk%'
          OR subject LIKE '%WE_kalk%' OR subject LIKE '%We kalk%' OR subject LIKE '%We-kalk%' OR subject LIKE
     '%We Kalkulation%' OR subject LIKE '%We-Kalkulation%'
  THEN 'WE-Kalkulation'
  WHEN subject LIKE '%Netto%' OR subject LIKE '%netto%'
  THEN 'Nettoleistung'
  WHEN subject LIKE '%Umsatz%' OR subject LIKE '%umsatz%' OR subject LIKE '%msätze%' OR subject LIKE '%urnover%'
  THEN 'Umsatz'
  WHEN subject LIKE '%Endanwender%' OR subject LIKE '%freischalten%' OR subject LIKE '%userid%' OR subject LIKE
                                '%erechtigung%' OR subject LIKE '%uthorization%' OR subject LIKE '%ccount%' OR subject
                             LIKE '%enutzerantrag%' OR subject LIKE '%ammelantrag%' OR subject LIKE '%errechtung%' OR
                          subject LIKE '%in Mis anlegen%' OR subject LIKE '%MIS User%' OR subject LIKE '%MIS user%' OR
                       subject LIKE '%MIS Role%' OR subject LIKE '%itabeiteraustritt%' OR subject LIKE
                     '%eurer Mitarbeiter%' OR subject LIKE '%nmeldung%' OR subject LIKE '%ugriff%' OR subject LIKE
                  '%ugangsdaten%' OR subject LIKE '%ugang%' OR subject LIKE '%right%' OR subject LIKE '%login%' OR
              subject LIKE '%Login%' OR subject LIKE '%access%' OR subject LIKE '%reischaltung%' OR subject LIKE
           '%grant%' OR subject LIKE '%asswor%' OR subject LIKE '%reset%' OR subject LIKE '%Reset%' OR subject LIKE
       '%Access%' OR subject LIKE '%Grant%' OR subject LIKE '%enehmigung%' OR subject LIKE '%account for%'
  THEN 'Zugriff/Berechtigung'
  WHEN subject LIKE '%PZE4%' OR subject LIKE '%GPS%' OR subject LIKE '%PTM%' OR subject LIKE '%rbeitszeiten%' OR subject
           LIKE '%hours%' OR subject LIKE '%Hours%' OR subject LIKE '%eiterfassung%' OR subject LIKE '%Ptm%' OR subject
       LIKE '%ptm%' OR subject LIKE '%Gps%' OR subject LIKE '%gps%' OR subject LIKE '%tunden%'
  THEN 'Zeiterfassung'
  WHEN subject LIKE '%utoD%' OR subject LIKE '%utod%' OR subject LIKE '%uto D%' OR subject LIKE '%uto d%'
  THEN 'AutoDispo'
  WHEN subject LIKE '%WFM%' OR subject LIKE '%wfm%'
  THEN 'WFM'
  WHEN subject LIKE '%mlagerung%' OR subject LIKE '%mzug%' OR subject LIKE '%mzüge%' OR subject LIKE '%ufschaltung%' OR
               subject LIKE '%amensänderung%' OR subject LIKE '%mgliederung%' OR subject LIKE '%ew WH%' OR subject LIKE
            '%ew warehouse%' OR subject LIKE '%eues WH%' OR subject LIKE '%eue Gesellschaft%' OR subject LIKE
         '%eue GES%' OR subject LIKE '%oft opening%' OR subject LIKE '%oftopening%' OR subject LIKE
      '%andesaufschaltung%' OR subject LIKE '%ountry initialization%' OR subject LIKE '%oft Opening%'
  THEN 'Aufschaltungen/Filialumzüge'
  WHEN subject LIKE '%eferenzdaten%' OR subject LIKE '%Refdata%' OR subject LIKE '%refdata%' OR subject LIKE
        '%Ref data%' OR subject LIKE '%ref data%' OR subject LIKE '%Ref-data%' OR subject LIKE '%ref-data%' OR subject
    LIKE '%eferencedata%'
  THEN 'Referenzdaten'
  WHEN subject LIKE '%Rabatt%' OR subject LIKE '%discount%' OR subject LIKE '%Discount%' OR subject LIKE '%abverkauf%'
    OR subject LIKE '%Abverkauf%' OR subject LIKE '%Abverkäufe%'
  THEN 'Rabatt'
  WHEN subject LIKE '%Rückgabe%' OR subject LIKE '%ückgabe%' OR subject LIKE '%Rücksende%'
  THEN 'Rückgabe'
  WHEN subject LIKE '%EJR%' OR subject LIKE '%Ejr%' OR subject LIKE '%ejr%' OR subject LIKE '%eJournale%' OR subject
          LIKE '%eceipt%' OR subject LIKE '%eciept%' OR subject LIKE '%Bondaten%' OR subject LIKE '%bondaten%' OR
      subject LIKE '%ZKP%' OR subject LIKE '%Zkp%' OR subject LIKE '%zkp%'
  THEN 'EJR'
  WHEN subject LIKE '%Annon%' OR subject LIKE '%annon%' OR subject LIKE '%ANNON%' OR subject LIKE '%Anon%'
  THEN 'ANNON'
  WHEN subject LIKE '%IMS%' OR subject LIKE '%Immo%'
  THEN 'IMS'
  WHEN subject LIKE '%PEP%'
  THEN 'PEP'
  WHEN subject LIKE '%LISA%' OR subject LIKE '%Lisa%' OR subject LIKE '%lisa%' OR subject LIKE '%LiSa%' OR subject LIKE
    '%LiSA%'
  THEN 'LISA'
  WHEN subject LIKE '%ockpit%' OR subject LIKE '%ocpit%'
  THEN 'Cockpit'
  WHEN subject LIKE '%ategory Management%'
  THEN 'Category Management'
  WHEN subject LIKE '%Rolle%' OR subject LIKE '%role%'
  THEN 'Rollen'
  WHEN subject LIKE '%SIAM%' OR subject LIKE '%IDM%'
  THEN 'SIAM/IDM'
  WHEN subject LIKE '%Kolli%' OR subject LIKE '%Koli%' OR subject LIKE '%kolli%' OR subject LIKE '%koli%' OR subject
     LIKE '%KOLLI%' OR subject LIKE '%KOLI%'
  THEN 'Kolli'
  WHEN subject LIKE '%Azure%' OR subject LIKE '%Devops%' OR subject LIKE '%Dev ops%' OR subject LIKE '%DevOps%' OR
       subject LIKE '%Dev Ops%' OR subject LIKE '%cloud%' OR subject LIKE '%Cloud%' OR subject LIKE '%CLOUD%'
  THEN 'Cloud'
  WHEN subject LIKE '%AfO%' OR subject LIKE '%AFO%' OR subject LIKE '%Afo%'
  THEN 'AfO'
  WHEN subject LIKE '%Oracle%'
  THEN 'Oracle'
  WHEN subject LIKE '%irewall%' OR subject LIKE '%omain%'
  THEN 'Firewall/Domain'
  WHEN subject LIKE '%iPad%' OR subject LIKE '%Ipad%' OR subject LIKE '%ipad%' OR subject LIKE '%IPAD%'
  THEN 'iPad'
  WHEN subject LIKE '%idlPlus%' OR subject LIKE '%Lidl Plus%' OR subject LIKE '%idlplus%' OR subject LIKE '%Lidl plus%'
   OR subject LIKE '%Lidl+%'
  THEN 'LidlPlus'
  WHEN subject LIKE '%LEAD%' OR subject LIKE '%Lead%' OR subject LIKE '%lead%'
  THEN 'MIS Lead'
  WHEN subject LIKE '%MSTR%' OR subject LIKE '%MicroStrategy%' OR subject LIKE '%Microstrategy%' OR subject LIKE
      '%Mstr%' OR subject LIKE '%MICRO%' OR subject LIKE '%Cubing%'
  THEN 'MicroStrategy'
  WHEN subject LIKE '%GL Regio%' OR subject LIKE '%GL-Regio%'
  THEN 'GL-Regio'
  WHEN subject LIKE '%binitio%' OR subject LIKE '%b initio%' OR subject LIKE '%binito%' OR subject LIKE '%b inito%' OR
      subject LIKE '%job%' OR subject LIKE '%Job%' OR subject LIKE '%bInitio%'
  THEN 'Ab Initio'
  WHEN subject LIKE '%DWH%' OR subject LIKE '%snow%' OR subject LIKE '%Snow%' OR subject LIKE '%Teradata%' OR subject
             LIKE '%t^_%' OR subject LIKE '%abelle%' OR subject LIKE '%column%' OR subject LIKE '%table%' OR subject
         LIKE '%uery%' OR subject LIKE '%ata export%' OR subject LIKE '%ata import%' OR subject LIKE '%Data Store%' OR
     subject LIKE '%Data store%' OR subject LIKE '%data store%'
  THEN 'Snowflake'
  WHEN subject LIKE '%WAWI%' OR subject LIKE '%Wawi%' OR subject LIKE '%WaWi%' OR subject LIKE '%wawi%'
  THEN 'WAWI'
  WHEN subject LIKE '%ilial%' OR subject LIKE '%Store%' OR subject LIKE '%Stores%' OR subject LIKE '%store%'
  THEN 'Filiale'
  WHEN subject LIKE '%rtikel%'
  THEN 'Artikel'
  WHEN subject LIKE '%eport documentation%' OR subject LIKE '%Report%' OR subject LIKE '%report%' OR subject LIKE
       '%dossier%' OR subject LIKE '%Dossier%' OR subject LIKE '%Bericht%' OR subject LIKE '%INT-%'
  THEN 'Bericht'
  WHEN subject LIKE '%SAP%'
  THEN 'SAP'
  WHEN subject LIKE '%MIS%' OR subject LIKE '%Mis%'
  THEN 'MIS'
  ELSE 'Sonstige'
  END AS topic,
  CASE
  WHEN CASE
    WHEN subject LIKE '%DES%'
    THEN 'DES'
    WHEN subject LIKE '%rite off%' OR subject LIKE '%bschreibung%' OR subject LIKE '%bschriften%' OR subject LIKE
      '%Write Off%'
    THEN 'Abschriften'
    WHEN subject LIKE '%Werbe%' OR subject LIKE '%werbe%' OR subject LIKE '%Advert%' OR subject LIKE '%advert%'
    THEN 'Werbeartikel/-termine'
    WHEN subject LIKE '%ieferant%'
    THEN 'Lieferant'
    WHEN subject LIKE '%torelist%'
    THEN 'MD-Storelist'
    WHEN subject LIKE '%langsam%' OR subject LIKE '%wird abgebrochen%' OR subject LIKE '%slow%'
    THEN 'Performance'
    WHEN subject LIKE '%utzungsgrad%'
    THEN 'PbV Nutzungsgrad'
    WHEN subject LIKE '%bersetzung%' OR subject LIKE '%ranslation%' OR subject LIKE '%prache%' OR subject LIKE
      '%anguage%'
    THEN 'Sprache/Übersetzung'
    WHEN subject LIKE '%nventur%' OR subject LIKE '%nventory%' OR subject LIKE '%nventories%'
    THEN 'Inventur'
    WHEN subject LIKE '%tückleistung%' OR subject LIKE '%tuckleistung%'
    THEN 'Stückleistung'
    WHEN subject LIKE '%STD%' OR subject LIKE '%rtikelbestände%' OR subject LIKE '%Bestand%' OR subject LIKE
         '%Bestände%' OR subject LIKE '%Stock%' OR subject LIKE '%stock%' OR subject LIKE '%bestände%'
    THEN 'STD Itemstock'
    WHEN subject LIKE '%alettenleistung%'
    THEN 'Palettenleistung'
    WHEN subject LIKE '%WE%' OR subject LIKE '%We-Kalk%' OR subject LIKE '%We Kalk%' OR subject LIKE '%WE_Kalk%' OR
              subject LIKE '%WE-Kalk%' OR subject LIKE '%WE Kalk%' OR subject LIKE '%WE-kalk%' OR subject LIKE
           '%WE kalk%' OR subject LIKE '%WE_kalk%' OR subject LIKE '%We kalk%' OR subject LIKE '%We-kalk%' OR subject
       LIKE '%We Kalkulation%' OR subject LIKE '%We-Kalkulation%'
    THEN 'WE-Kalkulation'
    WHEN subject LIKE '%Netto%' OR subject LIKE '%netto%'
    THEN 'Nettoleistung'
    WHEN subject LIKE '%Umsatz%' OR subject LIKE '%umsatz%' OR subject LIKE '%msätze%' OR subject LIKE '%urnover%'
    THEN 'Umsatz'
    WHEN subject LIKE '%Endanwender%' OR subject LIKE '%freischalten%' OR subject LIKE '%userid%' OR subject LIKE
                                  '%erechtigung%' OR subject LIKE '%uthorization%' OR subject LIKE '%ccount%' OR subject
                               LIKE '%enutzerantrag%' OR subject LIKE '%ammelantrag%' OR subject LIKE '%errechtung%' OR
                            subject LIKE '%in Mis anlegen%' OR subject LIKE '%MIS User%' OR subject LIKE '%MIS user%' OR
                         subject LIKE '%MIS Role%' OR subject LIKE '%itabeiteraustritt%' OR subject LIKE
                       '%eurer Mitarbeiter%' OR subject LIKE '%nmeldung%' OR subject LIKE '%ugriff%' OR subject LIKE
                    '%ugangsdaten%' OR subject LIKE '%ugang%' OR subject LIKE '%right%' OR subject LIKE '%login%' OR
                subject LIKE '%Login%' OR subject LIKE '%access%' OR subject LIKE '%reischaltung%' OR subject LIKE
             '%grant%' OR subject LIKE '%asswor%' OR subject LIKE '%reset%' OR subject LIKE '%Reset%' OR subject LIKE
         '%Access%' OR subject LIKE '%Grant%' OR subject LIKE '%enehmigung%' OR subject LIKE '%account for%'
    THEN 'Zugriff/Berechtigung'
    WHEN subject LIKE '%PZE4%' OR subject LIKE '%GPS%' OR subject LIKE '%PTM%' OR subject LIKE '%rbeitszeiten%' OR
             subject LIKE '%hours%' OR subject LIKE '%Hours%' OR subject LIKE '%eiterfassung%' OR subject LIKE '%Ptm%'
        OR subject LIKE '%ptm%' OR subject LIKE '%Gps%' OR subject LIKE '%gps%' OR subject LIKE '%tunden%'
    THEN 'Zeiterfassung'
    WHEN subject LIKE '%utoD%' OR subject LIKE '%utod%' OR subject LIKE '%uto D%' OR subject LIKE '%uto d%'
    THEN 'AutoDispo'
    WHEN subject LIKE '%WFM%' OR subject LIKE '%wfm%'
    THEN 'WFM'
    WHEN subject LIKE '%mlagerung%' OR subject LIKE '%mzug%' OR subject LIKE '%mzüge%' OR subject LIKE '%ufschaltung%'
                OR subject LIKE '%amensänderung%' OR subject LIKE '%mgliederung%' OR subject LIKE '%ew WH%' OR subject
              LIKE '%ew warehouse%' OR subject LIKE '%eues WH%' OR subject LIKE '%eue Gesellschaft%' OR subject LIKE
           '%eue GES%' OR subject LIKE '%oft opening%' OR subject LIKE '%oftopening%' OR subject LIKE
        '%andesaufschaltung%' OR subject LIKE '%ountry initialization%' OR subject LIKE '%oft Opening%'
    THEN 'Aufschaltungen/Filialumzüge'
    WHEN subject LIKE '%eferenzdaten%' OR subject LIKE '%Refdata%' OR subject LIKE '%refdata%' OR subject LIKE
          '%Ref data%' OR subject LIKE '%ref data%' OR subject LIKE '%Ref-data%' OR subject LIKE '%ref-data%' OR subject
      LIKE '%eferencedata%'
    THEN 'Referenzdaten'
    WHEN subject LIKE '%Rabatt%' OR subject LIKE '%discount%' OR subject LIKE '%Discount%' OR subject LIKE '%abverkauf%'
         OR subject LIKE '%Abverkauf%' OR subject LIKE '%Abverkäufe%'
    THEN 'Rabatt'
    WHEN subject LIKE '%Rückgabe%' OR subject LIKE '%ückgabe%' OR subject LIKE '%Rücksende%'
    THEN 'Rückgabe'
    WHEN subject LIKE '%EJR%' OR subject LIKE '%Ejr%' OR subject LIKE '%ejr%' OR subject LIKE '%eJournale%' OR subject
            LIKE '%eceipt%' OR subject LIKE '%eciept%' OR subject LIKE '%Bondaten%' OR subject LIKE '%bondaten%' OR
        subject LIKE '%ZKP%' OR subject LIKE '%Zkp%' OR subject LIKE '%zkp%'
    THEN 'EJR'
    WHEN subject LIKE '%Annon%' OR subject LIKE '%annon%' OR subject LIKE '%ANNON%' OR subject LIKE '%Anon%'
    THEN 'ANNON'
    WHEN subject LIKE '%IMS%' OR subject LIKE '%Immo%'
    THEN 'IMS'
    WHEN subject LIKE '%PEP%'
    THEN 'PEP'
    WHEN subject LIKE '%LISA%' OR subject LIKE '%Lisa%' OR subject LIKE '%lisa%' OR subject LIKE '%LiSa%' OR subject
      LIKE '%LiSA%'
    THEN 'LISA'
    WHEN subject LIKE '%ockpit%' OR subject LIKE '%ocpit%'
    THEN 'Cockpit'
    WHEN subject LIKE '%ategory Management%'
    THEN 'Category Management'
    WHEN subject LIKE '%Rolle%' OR subject LIKE '%role%'
    THEN 'Rollen'
    WHEN subject LIKE '%SIAM%' OR subject LIKE '%IDM%'
    THEN 'SIAM/IDM'
    WHEN subject LIKE '%Kolli%' OR subject LIKE '%Koli%' OR subject LIKE '%kolli%' OR subject LIKE '%koli%' OR subject
       LIKE '%KOLLI%' OR subject LIKE '%KOLI%'
    THEN 'Kolli'
    WHEN subject LIKE '%Azure%' OR subject LIKE '%Devops%' OR subject LIKE '%Dev ops%' OR subject LIKE '%DevOps%' OR
         subject LIKE '%Dev Ops%' OR subject LIKE '%cloud%' OR subject LIKE '%Cloud%' OR subject LIKE '%CLOUD%'
    THEN 'Cloud'
    WHEN subject LIKE '%AfO%' OR subject LIKE '%AFO%' OR subject LIKE '%Afo%'
    THEN 'AfO'
    WHEN subject LIKE '%Oracle%'
    THEN 'Oracle'
    WHEN subject LIKE '%irewall%' OR subject LIKE '%omain%'
    THEN 'Firewall/Domain'
    WHEN subject LIKE '%iPad%' OR subject LIKE '%Ipad%' OR subject LIKE '%ipad%' OR subject LIKE '%IPAD%'
    THEN 'iPad'
    WHEN subject LIKE '%idlPlus%' OR subject LIKE '%Lidl Plus%' OR subject LIKE '%idlplus%' OR subject LIKE
       '%Lidl plus%' OR subject LIKE '%Lidl+%'
    THEN 'LidlPlus'
    WHEN subject LIKE '%LEAD%' OR subject LIKE '%Lead%' OR subject LIKE '%lead%'
    THEN 'MIS Lead'
    WHEN subject LIKE '%MSTR%' OR subject LIKE '%MicroStrategy%' OR subject LIKE '%Microstrategy%' OR subject LIKE
        '%Mstr%' OR subject LIKE '%MICRO%' OR subject LIKE '%Cubing%'
    THEN 'MicroStrategy'
    WHEN subject LIKE '%GL Regio%' OR subject LIKE '%GL-Regio%'
    THEN 'GL-Regio'
    WHEN subject LIKE '%binitio%' OR subject LIKE '%b initio%' OR subject LIKE '%binito%' OR subject LIKE '%b inito%' OR
        subject LIKE '%job%' OR subject LIKE '%Job%' OR subject LIKE '%bInitio%'
    THEN 'Ab Initio'
    WHEN subject LIKE '%DWH%' OR subject LIKE '%snow%' OR subject LIKE '%Snow%' OR subject LIKE '%Teradata%' OR subject
               LIKE '%t^_%' OR subject LIKE '%abelle%' OR subject LIKE '%column%' OR subject LIKE '%table%' OR subject
           LIKE '%uery%' OR subject LIKE '%ata export%' OR subject LIKE '%ata import%' OR subject LIKE '%Data Store%' OR
       subject LIKE '%Data store%' OR subject LIKE '%data store%'
    THEN 'Snowflake'
    WHEN subject LIKE '%WAWI%' OR subject LIKE '%Wawi%' OR subject LIKE '%WaWi%' OR subject LIKE '%wawi%'
    THEN 'WAWI'
    WHEN subject LIKE '%ilial%' OR subject LIKE '%Store%' OR subject LIKE '%Stores%' OR subject LIKE '%store%'
    THEN 'Filiale'
    WHEN subject LIKE '%rtikel%'
    THEN 'Artikel'
    WHEN subject LIKE '%eport documentation%' OR subject LIKE '%Report%' OR subject LIKE '%report%' OR subject LIKE
         '%dossier%' OR subject LIKE '%Dossier%' OR subject LIKE '%Bericht%' OR subject LIKE '%INT-%'
    THEN 'Bericht'
    WHEN subject LIKE '%SAP%'
    THEN 'SAP'
    WHEN subject LIKE '%MIS%' OR subject LIKE '%Mis%'
    THEN 'MIS'
    ELSE 'Sonstige'
    END IN ('Abschriften', 'Werbeartikel/-termine', 'PbV Nutzungsgrad', 'Inventur', 'Stückleistung', 'Lieferant',
    'STD Itemstock', 'Palettenleistung', 'WE-Kalkulation', 'Nettoleistung', 'Umsatz', 'WFM', 'Zeiterfassung', 'Rabatt',
    'Rückgabe', 'Kolli')
  THEN 'Kennzahlen'
  WHEN CASE
    WHEN subject LIKE '%DES%'
    THEN 'DES'
    WHEN subject LIKE '%rite off%' OR subject LIKE '%bschreibung%' OR subject LIKE '%bschriften%' OR subject LIKE
      '%Write Off%'
    THEN 'Abschriften'
    WHEN subject LIKE '%Werbe%' OR subject LIKE '%werbe%' OR subject LIKE '%Advert%' OR subject LIKE '%advert%'
    THEN 'Werbeartikel/-termine'
    WHEN subject LIKE '%ieferant%'
    THEN 'Lieferant'
    WHEN subject LIKE '%torelist%'
    THEN 'MD-Storelist'
    WHEN subject LIKE '%langsam%' OR subject LIKE '%wird abgebrochen%' OR subject LIKE '%slow%'
    THEN 'Performance'
    WHEN subject LIKE '%utzungsgrad%'
    THEN 'PbV Nutzungsgrad'
    WHEN subject LIKE '%bersetzung%' OR subject LIKE '%ranslation%' OR subject LIKE '%prache%' OR subject LIKE
      '%anguage%'
    THEN 'Sprache/Übersetzung'
    WHEN subject LIKE '%nventur%' OR subject LIKE '%nventory%' OR subject LIKE '%nventories%'
    THEN 'Inventur'
    WHEN subject LIKE '%tückleistung%' OR subject LIKE '%tuckleistung%'
    THEN 'Stückleistung'
    WHEN subject LIKE '%STD%' OR subject LIKE '%rtikelbestände%' OR subject LIKE '%Bestand%' OR subject LIKE
         '%Bestände%' OR subject LIKE '%Stock%' OR subject LIKE '%stock%' OR subject LIKE '%bestände%'
    THEN 'STD Itemstock'
    WHEN subject LIKE '%alettenleistung%'
    THEN 'Palettenleistung'
    WHEN subject LIKE '%WE%' OR subject LIKE '%We-Kalk%' OR subject LIKE '%We Kalk%' OR subject LIKE '%WE_Kalk%' OR
              subject LIKE '%WE-Kalk%' OR subject LIKE '%WE Kalk%' OR subject LIKE '%WE-kalk%' OR subject LIKE
           '%WE kalk%' OR subject LIKE '%WE_kalk%' OR subject LIKE '%We kalk%' OR subject LIKE '%We-kalk%' OR subject
       LIKE '%We Kalkulation%' OR subject LIKE '%We-Kalkulation%'
    THEN 'WE-Kalkulation'
    WHEN subject LIKE '%Netto%' OR subject LIKE '%netto%'
    THEN 'Nettoleistung'
    WHEN subject LIKE '%Umsatz%' OR subject LIKE '%umsatz%' OR subject LIKE '%msätze%' OR subject LIKE '%urnover%'
    THEN 'Umsatz'
    WHEN subject LIKE '%Endanwender%' OR subject LIKE '%freischalten%' OR subject LIKE '%userid%' OR subject LIKE
                                  '%erechtigung%' OR subject LIKE '%uthorization%' OR subject LIKE '%ccount%' OR subject
                               LIKE '%enutzerantrag%' OR subject LIKE '%ammelantrag%' OR subject LIKE '%errechtung%' OR
                            subject LIKE '%in Mis anlegen%' OR subject LIKE '%MIS User%' OR subject LIKE '%MIS user%' OR
                         subject LIKE '%MIS Role%' OR subject LIKE '%itabeiteraustritt%' OR subject LIKE
                       '%eurer Mitarbeiter%' OR subject LIKE '%nmeldung%' OR subject LIKE '%ugriff%' OR subject LIKE
                    '%ugangsdaten%' OR subject LIKE '%ugang%' OR subject LIKE '%right%' OR subject LIKE '%login%' OR
                subject LIKE '%Login%' OR subject LIKE '%access%' OR subject LIKE '%reischaltung%' OR subject LIKE
             '%grant%' OR subject LIKE '%asswor%' OR subject LIKE '%reset%' OR subject LIKE '%Reset%' OR subject LIKE
         '%Access%' OR subject LIKE '%Grant%' OR subject LIKE '%enehmigung%' OR subject LIKE '%account for%'
    THEN 'Zugriff/Berechtigung'
    WHEN subject LIKE '%PZE4%' OR subject LIKE '%GPS%' OR subject LIKE '%PTM%' OR subject LIKE '%rbeitszeiten%' OR
             subject LIKE '%hours%' OR subject LIKE '%Hours%' OR subject LIKE '%eiterfassung%' OR subject LIKE '%Ptm%'
        OR subject LIKE '%ptm%' OR subject LIKE '%Gps%' OR subject LIKE '%gps%' OR subject LIKE '%tunden%'
    THEN 'Zeiterfassung'
    WHEN subject LIKE '%utoD%' OR subject LIKE '%utod%' OR subject LIKE '%uto D%' OR subject LIKE '%uto d%'
    THEN 'AutoDispo'
    WHEN subject LIKE '%WFM%' OR subject LIKE '%wfm%'
    THEN 'WFM'
    WHEN subject LIKE '%mlagerung%' OR subject LIKE '%mzug%' OR subject LIKE '%mzüge%' OR subject LIKE '%ufschaltung%'
                OR subject LIKE '%amensänderung%' OR subject LIKE '%mgliederung%' OR subject LIKE '%ew WH%' OR subject
              LIKE '%ew warehouse%' OR subject LIKE '%eues WH%' OR subject LIKE '%eue Gesellschaft%' OR subject LIKE
           '%eue GES%' OR subject LIKE '%oft opening%' OR subject LIKE '%oftopening%' OR subject LIKE
        '%andesaufschaltung%' OR subject LIKE '%ountry initialization%' OR subject LIKE '%oft Opening%'
    THEN 'Aufschaltungen/Filialumzüge'
    WHEN subject LIKE '%eferenzdaten%' OR subject LIKE '%Refdata%' OR subject LIKE '%refdata%' OR subject LIKE
          '%Ref data%' OR subject LIKE '%ref data%' OR subject LIKE '%Ref-data%' OR subject LIKE '%ref-data%' OR subject
      LIKE '%eferencedata%'
    THEN 'Referenzdaten'
    WHEN subject LIKE '%Rabatt%' OR subject LIKE '%discount%' OR subject LIKE '%Discount%' OR subject LIKE '%abverkauf%'
         OR subject LIKE '%Abverkauf%' OR subject LIKE '%Abverkäufe%'
    THEN 'Rabatt'
    WHEN subject LIKE '%Rückgabe%' OR subject LIKE '%ückgabe%' OR subject LIKE '%Rücksende%'
    THEN 'Rückgabe'
    WHEN subject LIKE '%EJR%' OR subject LIKE '%Ejr%' OR subject LIKE '%ejr%' OR subject LIKE '%eJournale%' OR subject
            LIKE '%eceipt%' OR subject LIKE '%eciept%' OR subject LIKE '%Bondaten%' OR subject LIKE '%bondaten%' OR
        subject LIKE '%ZKP%' OR subject LIKE '%Zkp%' OR subject LIKE '%zkp%'
    THEN 'EJR'
    WHEN subject LIKE '%Annon%' OR subject LIKE '%annon%' OR subject LIKE '%ANNON%' OR subject LIKE '%Anon%'
    THEN 'ANNON'
    WHEN subject LIKE '%IMS%' OR subject LIKE '%Immo%'
    THEN 'IMS'
    WHEN subject LIKE '%PEP%'
    THEN 'PEP'
    WHEN subject LIKE '%LISA%' OR subject LIKE '%Lisa%' OR subject LIKE '%lisa%' OR subject LIKE '%LiSa%' OR subject
      LIKE '%LiSA%'
    THEN 'LISA'
    WHEN subject LIKE '%ockpit%' OR subject LIKE '%ocpit%'
    THEN 'Cockpit'
    WHEN subject LIKE '%ategory Management%'
    THEN 'Category Management'
    WHEN subject LIKE '%Rolle%' OR subject LIKE '%role%'
    THEN 'Rollen'
    WHEN subject LIKE '%SIAM%' OR subject LIKE '%IDM%'
    THEN 'SIAM/IDM'
    WHEN subject LIKE '%Kolli%' OR subject LIKE '%Koli%' OR subject LIKE '%kolli%' OR subject LIKE '%koli%' OR subject
       LIKE '%KOLLI%' OR subject LIKE '%KOLI%'
    THEN 'Kolli'
    WHEN subject LIKE '%Azure%' OR subject LIKE '%Devops%' OR subject LIKE '%Dev ops%' OR subject LIKE '%DevOps%' OR
         subject LIKE '%Dev Ops%' OR subject LIKE '%cloud%' OR subject LIKE '%Cloud%' OR subject LIKE '%CLOUD%'
    THEN 'Cloud'
    WHEN subject LIKE '%AfO%' OR subject LIKE '%AFO%' OR subject LIKE '%Afo%'
    THEN 'AfO'
    WHEN subject LIKE '%Oracle%'
    THEN 'Oracle'
    WHEN subject LIKE '%irewall%' OR subject LIKE '%omain%'
    THEN 'Firewall/Domain'
    WHEN subject LIKE '%iPad%' OR subject LIKE '%Ipad%' OR subject LIKE '%ipad%' OR subject LIKE '%IPAD%'
    THEN 'iPad'
    WHEN subject LIKE '%idlPlus%' OR subject LIKE '%Lidl Plus%' OR subject LIKE '%idlplus%' OR subject LIKE
       '%Lidl plus%' OR subject LIKE '%Lidl+%'
    THEN 'LidlPlus'
    WHEN subject LIKE '%LEAD%' OR subject LIKE '%Lead%' OR subject LIKE '%lead%'
    THEN 'MIS Lead'
    WHEN subject LIKE '%MSTR%' OR subject LIKE '%MicroStrategy%' OR subject LIKE '%Microstrategy%' OR subject LIKE
        '%Mstr%' OR subject LIKE '%MICRO%' OR subject LIKE '%Cubing%'
    THEN 'MicroStrategy'
    WHEN subject LIKE '%GL Regio%' OR subject LIKE '%GL-Regio%'
    THEN 'GL-Regio'
    WHEN subject LIKE '%binitio%' OR subject LIKE '%b initio%' OR subject LIKE '%binito%' OR subject LIKE '%b inito%' OR
        subject LIKE '%job%' OR subject LIKE '%Job%' OR subject LIKE '%bInitio%'
    THEN 'Ab Initio'
    WHEN subject LIKE '%DWH%' OR subject LIKE '%snow%' OR subject LIKE '%Snow%' OR subject LIKE '%Teradata%' OR subject
               LIKE '%t^_%' OR subject LIKE '%abelle%' OR subject LIKE '%column%' OR subject LIKE '%table%' OR subject
           LIKE '%uery%' OR subject LIKE '%ata export%' OR subject LIKE '%ata import%' OR subject LIKE '%Data Store%' OR
       subject LIKE '%Data store%' OR subject LIKE '%data store%'
    THEN 'Snowflake'
    WHEN subject LIKE '%WAWI%' OR subject LIKE '%Wawi%' OR subject LIKE '%WaWi%' OR subject LIKE '%wawi%'
    THEN 'WAWI'
    WHEN subject LIKE '%ilial%' OR subject LIKE '%Store%' OR subject LIKE '%Stores%' OR subject LIKE '%store%'
    THEN 'Filiale'
    WHEN subject LIKE '%rtikel%'
    THEN 'Artikel'
    WHEN subject LIKE '%eport documentation%' OR subject LIKE '%Report%' OR subject LIKE '%report%' OR subject LIKE
         '%dossier%' OR subject LIKE '%Dossier%' OR subject LIKE '%Bericht%' OR subject LIKE '%INT-%'
    THEN 'Bericht'
    WHEN subject LIKE '%SAP%'
    THEN 'SAP'
    WHEN subject LIKE '%MIS%' OR subject LIKE '%Mis%'
    THEN 'MIS'
    ELSE 'Sonstige'
    END IN ('Rollen', 'Zugriff/Berechtigung', 'SIAM/IDM')
  THEN 'User Berechtigung'
  WHEN CASE
    WHEN subject LIKE '%DES%'
    THEN 'DES'
    WHEN subject LIKE '%rite off%' OR subject LIKE '%bschreibung%' OR subject LIKE '%bschriften%' OR subject LIKE
      '%Write Off%'
    THEN 'Abschriften'
    WHEN subject LIKE '%Werbe%' OR subject LIKE '%werbe%' OR subject LIKE '%Advert%' OR subject LIKE '%advert%'
    THEN 'Werbeartikel/-termine'
    WHEN subject LIKE '%ieferant%'
    THEN 'Lieferant'
    WHEN subject LIKE '%torelist%'
    THEN 'MD-Storelist'
    WHEN subject LIKE '%langsam%' OR subject LIKE '%wird abgebrochen%' OR subject LIKE '%slow%'
    THEN 'Performance'
    WHEN subject LIKE '%utzungsgrad%'
    THEN 'PbV Nutzungsgrad'
    WHEN subject LIKE '%bersetzung%' OR subject LIKE '%ranslation%' OR subject LIKE '%prache%' OR subject LIKE
      '%anguage%'
    THEN 'Sprache/Übersetzung'
    WHEN subject LIKE '%nventur%' OR subject LIKE '%nventory%' OR subject LIKE '%nventories%'
    THEN 'Inventur'
    WHEN subject LIKE '%tückleistung%' OR subject LIKE '%tuckleistung%'
    THEN 'Stückleistung'
    WHEN subject LIKE '%STD%' OR subject LIKE '%rtikelbestände%' OR subject LIKE '%Bestand%' OR subject LIKE
         '%Bestände%' OR subject LIKE '%Stock%' OR subject LIKE '%stock%' OR subject LIKE '%bestände%'
    THEN 'STD Itemstock'
    WHEN subject LIKE '%alettenleistung%'
    THEN 'Palettenleistung'
    WHEN subject LIKE '%WE%' OR subject LIKE '%We-Kalk%' OR subject LIKE '%We Kalk%' OR subject LIKE '%WE_Kalk%' OR
              subject LIKE '%WE-Kalk%' OR subject LIKE '%WE Kalk%' OR subject LIKE '%WE-kalk%' OR subject LIKE
           '%WE kalk%' OR subject LIKE '%WE_kalk%' OR subject LIKE '%We kalk%' OR subject LIKE '%We-kalk%' OR subject
       LIKE '%We Kalkulation%' OR subject LIKE '%We-Kalkulation%'
    THEN 'WE-Kalkulation'
    WHEN subject LIKE '%Netto%' OR subject LIKE '%netto%'
    THEN 'Nettoleistung'
    WHEN subject LIKE '%Umsatz%' OR subject LIKE '%umsatz%' OR subject LIKE '%msätze%' OR subject LIKE '%urnover%'
    THEN 'Umsatz'
    WHEN subject LIKE '%Endanwender%' OR subject LIKE '%freischalten%' OR subject LIKE '%userid%' OR subject LIKE
                                  '%erechtigung%' OR subject LIKE '%uthorization%' OR subject LIKE '%ccount%' OR subject
                               LIKE '%enutzerantrag%' OR subject LIKE '%ammelantrag%' OR subject LIKE '%errechtung%' OR
                            subject LIKE '%in Mis anlegen%' OR subject LIKE '%MIS User%' OR subject LIKE '%MIS user%' OR
                         subject LIKE '%MIS Role%' OR subject LIKE '%itabeiteraustritt%' OR subject LIKE
                       '%eurer Mitarbeiter%' OR subject LIKE '%nmeldung%' OR subject LIKE '%ugriff%' OR subject LIKE
                    '%ugangsdaten%' OR subject LIKE '%ugang%' OR subject LIKE '%right%' OR subject LIKE '%login%' OR
                subject LIKE '%Login%' OR subject LIKE '%access%' OR subject LIKE '%reischaltung%' OR subject LIKE
             '%grant%' OR subject LIKE '%asswor%' OR subject LIKE '%reset%' OR subject LIKE '%Reset%' OR subject LIKE
         '%Access%' OR subject LIKE '%Grant%' OR subject LIKE '%enehmigung%' OR subject LIKE '%account for%'
    THEN 'Zugriff/Berechtigung'
    WHEN subject LIKE '%PZE4%' OR subject LIKE '%GPS%' OR subject LIKE '%PTM%' OR subject LIKE '%rbeitszeiten%' OR
             subject LIKE '%hours%' OR subject LIKE '%Hours%' OR subject LIKE '%eiterfassung%' OR subject LIKE '%Ptm%'
        OR subject LIKE '%ptm%' OR subject LIKE '%Gps%' OR subject LIKE '%gps%' OR subject LIKE '%tunden%'
    THEN 'Zeiterfassung'
    WHEN subject LIKE '%utoD%' OR subject LIKE '%utod%' OR subject LIKE '%uto D%' OR subject LIKE '%uto d%'
    THEN 'AutoDispo'
    WHEN subject LIKE '%WFM%' OR subject LIKE '%wfm%'
    THEN 'WFM'
    WHEN subject LIKE '%mlagerung%' OR subject LIKE '%mzug%' OR subject LIKE '%mzüge%' OR subject LIKE '%ufschaltung%'
                OR subject LIKE '%amensänderung%' OR subject LIKE '%mgliederung%' OR subject LIKE '%ew WH%' OR subject
              LIKE '%ew warehouse%' OR subject LIKE '%eues WH%' OR subject LIKE '%eue Gesellschaft%' OR subject LIKE
           '%eue GES%' OR subject LIKE '%oft opening%' OR subject LIKE '%oftopening%' OR subject LIKE
        '%andesaufschaltung%' OR subject LIKE '%ountry initialization%' OR subject LIKE '%oft Opening%'
    THEN 'Aufschaltungen/Filialumzüge'
    WHEN subject LIKE '%eferenzdaten%' OR subject LIKE '%Refdata%' OR subject LIKE '%refdata%' OR subject LIKE
          '%Ref data%' OR subject LIKE '%ref data%' OR subject LIKE '%Ref-data%' OR subject LIKE '%ref-data%' OR subject
      LIKE '%eferencedata%'
    THEN 'Referenzdaten'
    WHEN subject LIKE '%Rabatt%' OR subject LIKE '%discount%' OR subject LIKE '%Discount%' OR subject LIKE '%abverkauf%'
         OR subject LIKE '%Abverkauf%' OR subject LIKE '%Abverkäufe%'
    THEN 'Rabatt'
    WHEN subject LIKE '%Rückgabe%' OR subject LIKE '%ückgabe%' OR subject LIKE '%Rücksende%'
    THEN 'Rückgabe'
    WHEN subject LIKE '%EJR%' OR subject LIKE '%Ejr%' OR subject LIKE '%ejr%' OR subject LIKE '%eJournale%' OR subject
            LIKE '%eceipt%' OR subject LIKE '%eciept%' OR subject LIKE '%Bondaten%' OR subject LIKE '%bondaten%' OR
        subject LIKE '%ZKP%' OR subject LIKE '%Zkp%' OR subject LIKE '%zkp%'
    THEN 'EJR'
    WHEN subject LIKE '%Annon%' OR subject LIKE '%annon%' OR subject LIKE '%ANNON%' OR subject LIKE '%Anon%'
    THEN 'ANNON'
    WHEN subject LIKE '%IMS%' OR subject LIKE '%Immo%'
    THEN 'IMS'
    WHEN subject LIKE '%PEP%'
    THEN 'PEP'
    WHEN subject LIKE '%LISA%' OR subject LIKE '%Lisa%' OR subject LIKE '%lisa%' OR subject LIKE '%LiSa%' OR subject
      LIKE '%LiSA%'
    THEN 'LISA'
    WHEN subject LIKE '%ockpit%' OR subject LIKE '%ocpit%'
    THEN 'Cockpit'
    WHEN subject LIKE '%ategory Management%'
    THEN 'Category Management'
    WHEN subject LIKE '%Rolle%' OR subject LIKE '%role%'
    THEN 'Rollen'
    WHEN subject LIKE '%SIAM%' OR subject LIKE '%IDM%'
    THEN 'SIAM/IDM'
    WHEN subject LIKE '%Kolli%' OR subject LIKE '%Koli%' OR subject LIKE '%kolli%' OR subject LIKE '%koli%' OR subject
       LIKE '%KOLLI%' OR subject LIKE '%KOLI%'
    THEN 'Kolli'
    WHEN subject LIKE '%Azure%' OR subject LIKE '%Devops%' OR subject LIKE '%Dev ops%' OR subject LIKE '%DevOps%' OR
         subject LIKE '%Dev Ops%' OR subject LIKE '%cloud%' OR subject LIKE '%Cloud%' OR subject LIKE '%CLOUD%'
    THEN 'Cloud'
    WHEN subject LIKE '%AfO%' OR subject LIKE '%AFO%' OR subject LIKE '%Afo%'
    THEN 'AfO'
    WHEN subject LIKE '%Oracle%'
    THEN 'Oracle'
    WHEN subject LIKE '%irewall%' OR subject LIKE '%omain%'
    THEN 'Firewall/Domain'
    WHEN subject LIKE '%iPad%' OR subject LIKE '%Ipad%' OR subject LIKE '%ipad%' OR subject LIKE '%IPAD%'
    THEN 'iPad'
    WHEN subject LIKE '%idlPlus%' OR subject LIKE '%Lidl Plus%' OR subject LIKE '%idlplus%' OR subject LIKE
       '%Lidl plus%' OR subject LIKE '%Lidl+%'
    THEN 'LidlPlus'
    WHEN subject LIKE '%LEAD%' OR subject LIKE '%Lead%' OR subject LIKE '%lead%'
    THEN 'MIS Lead'
    WHEN subject LIKE '%MSTR%' OR subject LIKE '%MicroStrategy%' OR subject LIKE '%Microstrategy%' OR subject LIKE
        '%Mstr%' OR subject LIKE '%MICRO%' OR subject LIKE '%Cubing%'
    THEN 'MicroStrategy'
    WHEN subject LIKE '%GL Regio%' OR subject LIKE '%GL-Regio%'
    THEN 'GL-Regio'
    WHEN subject LIKE '%binitio%' OR subject LIKE '%b initio%' OR subject LIKE '%binito%' OR subject LIKE '%b inito%' OR
        subject LIKE '%job%' OR subject LIKE '%Job%' OR subject LIKE '%bInitio%'
    THEN 'Ab Initio'
    WHEN subject LIKE '%DWH%' OR subject LIKE '%snow%' OR subject LIKE '%Snow%' OR subject LIKE '%Teradata%' OR subject
               LIKE '%t^_%' OR subject LIKE '%abelle%' OR subject LIKE '%column%' OR subject LIKE '%table%' OR subject
           LIKE '%uery%' OR subject LIKE '%ata export%' OR subject LIKE '%ata import%' OR subject LIKE '%Data Store%' OR
       subject LIKE '%Data store%' OR subject LIKE '%data store%'
    THEN 'Snowflake'
    WHEN subject LIKE '%WAWI%' OR subject LIKE '%Wawi%' OR subject LIKE '%WaWi%' OR subject LIKE '%wawi%'
    THEN 'WAWI'
    WHEN subject LIKE '%ilial%' OR subject LIKE '%Store%' OR subject LIKE '%Stores%' OR subject LIKE '%store%'
    THEN 'Filiale'
    WHEN subject LIKE '%rtikel%'
    THEN 'Artikel'
    WHEN subject LIKE '%eport documentation%' OR subject LIKE '%Report%' OR subject LIKE '%report%' OR subject LIKE
         '%dossier%' OR subject LIKE '%Dossier%' OR subject LIKE '%Bericht%' OR subject LIKE '%INT-%'
    THEN 'Bericht'
    WHEN subject LIKE '%SAP%'
    THEN 'SAP'
    WHEN subject LIKE '%MIS%' OR subject LIKE '%Mis%'
    THEN 'MIS'
    ELSE 'Sonstige'
    END IN ('Ab Initio', 'MIS', 'Snowflake', 'MicroStrategy', 'Annon', 'WAWI', 'Oracle', 'SAP', 'IMS', 'LISA', 'PEP',
    'DES')
  THEN 'System'
  ELSE NULL
  END AS category
FROM ldl_bcbi_fe_mstr_bcbi.v_tickets_daily;