create or replace TABLE KFL_PRODUCTION.DBP_MSI_DATA.TS_KMR_USER_SEC_KZ_ZU_2 (
	USER_ID VARCHAR(30) NOT NULL COMMENT 'MSI-User. Hier nur fuer das Produkt KMR, darum keine Spalte msi_produkt_bez.',
	SEC_KZ NUMBER(38,0) NOT NULL COMMENT 'Kennzeichen der Zugriffssteuerung fuer die Anwendung KMR in MSI (z.B. Zugriff auf die Daten fuer KDC, MZK, WMD, K-Visit, etc.) - wird manuell beladen.',
	constraint PK_TS_KMR_USER_SEC_KZ_ZU primary key (USER_ID, SEC_KZ)
)COMMENT='KMR - This table contains only KMR MSI users. It assigns a security indicator (Sicherheitskennzeichen) sec_kz to a user, which is needed for access control of the KMR applications withing MSI.'
;