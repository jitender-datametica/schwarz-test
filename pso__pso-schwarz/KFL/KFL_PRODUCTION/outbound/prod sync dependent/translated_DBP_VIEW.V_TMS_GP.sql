CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tms_gp (mandant_id OPTIONS(description='Mandant im DWH'), system_id
OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_gp_id
OPTIONS(description='ID des Geschäftspartners. Aus plkd.nr'), tms_gp_typ_cd
OPTIONS(description='Geschäftspartnertyp. L = Lager, S = Spediteur, 0(null) = Markt(Kunde)'), tms_gp_lfd_nr
OPTIONS(description='SKey für die Tabelle tms_gp im Quellsystem. Aus plkd.kd_id'), tms_gp_name
OPTIONS(description='Name des Geschäftspartners'), tms_gp_altnv_name
OPTIONS(description='Alternativer Name des Geschäftspartners'), tms_gp_strasse
OPTIONS(description='Straße des Geschäftspartners Adresse'), tms_gp_ort_name
OPTIONS(description='Ort des Geschäftspartners Adresse'), tms_gp_plz
OPTIONS(description='Postleitzahl des Geschäftspartners Adresse'), tms_land_cd OPTIONS(description='Länderkennzeichen'),
sperr_fg OPTIONS(description='Kennzeichnung für Sperrung des Kunden'), sammelbeleg_id
OPTIONS(description='Kennzeichen für Sammelbelege (aktuell nur J/N/leer)'), tms_standorttyp_id
OPTIONS(description='Standort-Typ (Außenlager, VZ, FLW, Markt,…)')) AS SELECT mandant_id,
 system_id,
 tms_gp_id,
 tms_gp_typ_cd,
 tms_gp_lfd_nr,
 tms_gp_name,
 tms_gp_altnv_name,
 tms_gp_strasse,
 tms_gp_ort_name,
 tms_gp_plz,
 tms_land_cd,
 sperr_fg,
 sammelbeleg_id,
 tms_standorttyp_id
FROM kfl_production_dbp_data.tms_gp;