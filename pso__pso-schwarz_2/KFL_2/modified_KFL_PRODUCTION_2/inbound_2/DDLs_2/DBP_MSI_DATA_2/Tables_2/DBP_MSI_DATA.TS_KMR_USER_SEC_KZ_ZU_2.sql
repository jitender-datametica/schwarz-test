--==============================================================
-- Table: ts_kmr_user_sec_kz_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_kmr_user_sec_kz_zu_2
   generated from Powerdesigner on Wednesday, August 24, 2022 6:52:35 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_KMR_USER_SEC_KZ_ZU_2 (
   user_id                             VARCHAR(30)     NOT NULL COMMENT 'MSI-User. Hier nur fuer das Produkt KMR, darum keine Spalte msi_produkt_bez.',
   sec_kz                              INTEGER    NOT NULL COMMENT 'Kennzeichen der Zugriffssteuerung fuer die Anwendung KMR in MSI (z.B. Zugriff auf die Daten fuer KDC, MZK, WMD, K-Visit, etc.) - wird manuell beladen.',
   CONSTRAINT PK_TS_KMR_USER_SEC_KZ_ZU PRIMARY KEY (user_id, sec_kz) NOT ENFORCED
)  COMMENT = 'KMR - This table contains only KMR MSI users. It assigns a security indicator (Sicherheitskennzeichen) sec_kz to a user, which is needed for access control of the KMR applications withing MSI.';
