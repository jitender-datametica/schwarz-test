--==============================================================
-- Table: artbew_gp_sum_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_gp_sum_2
   generated from Powerdesigner on Mittwoch, 18. Dezember 2024 18:05:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artbew_gp_sum_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_2-TT'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)            '),
vw_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Vertriebswegs. Einkaufs-Sicht auf die wup_2 Objekte            1 = Ost            2 = West            3 = Nord'),
wrg_2 STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Währung, z.Bsp. EUR'),
umrechnungskurs_hist BIGNUMERIC(38,5) DEFAULT 0 NOT NULL
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs_2 '),
umsatz_netto NUMERIC(18,4) NOT NULL OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'),
diff_umsatz_netto_konz NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='von der Konzernwährung abweichender Umsatz netto'),
ek_mep NUMERIC(18,4) NOT NULL OPTIONS(description='Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema)'),
diff_ek_mep_konz NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='von der Konzernwährung abweichender Einkaufspreis Markteinstandspreis'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dat, gp_id, vw_id) NOT ENFORCED
)
OPTIONS(description='TP2_AIS - Aggregatstabelle enthält Umsatz und MEP pro Lieferant, Vertriebsweg und Tag_2 - MULTISET');