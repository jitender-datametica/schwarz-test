--==============================================================
-- Table: ts_kmr_user_sec_kz_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_kmr_user_sec_kz_zu_2
   generated from Powerdesigner on Wednesday, August 24, 2022 6:52:35 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ts_kmr_user_sec_kz_zu_2 (
user_id STRING(30) NOT NULL
OPTIONS(description='MSI-User. Hier nur fuer das Produkt KMR, darum keine Spalte msi_produkt_bez.'),
sec_kz BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichen der Zugriffssteuerung fuer die Anwendung KMR in MSI (z.B. Zugriff auf die Daten fuer KDC, MZK, WMD, K-Visit, etc.) - wird manuell beladen.'),
PRIMARY KEY (user_id, sec_kz) NOT ENFORCED
)
OPTIONS(description='KMR - This table contains only KMR MSI users. It assigns a security indicator (Sicherheitskennzeichen) sec_kz to a user, which is needed for access control of the KMR applications withing MSI.');