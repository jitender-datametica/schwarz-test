--==============================================================
-- Table: user_rolle_ek_int_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: user_rolle_ek_int_zu
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:19:36
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_SECURITY.USER_ROLLE_EK_INT_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   user_id                             VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'ID des MSI Users',
   rolle_id                            INTEGER     COMMENT 'ID der Rolle (Zuweisung ob ZEK, WBL (EKL) oder GF)',
   rolle_bez                           VARCHAR(30)      COLLATE 'en-ci' COMMENT 'Bezeichung der Rolle (ZEK, WBL (EKL) oder GF)',
   zek_id                              VARCHAR(3)       COMMENT 'falls Rolle = ZEK steht hier die Zentraleinkäufer - ID',
   wbl_id                              INTEGER     COMMENT 'falls Rolle = WBL steht hier die Warenbereichsleiter(EKL) ID ',
   gf_id                               INTEGER     COMMENT 'falls Rolle = GF steht hier dieGeschäftsführer ID',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_USER_ROLLE_EK_INT_ZU PRIMARY KEY (mandant_id, user_id) NOT ENFORCED
)  COMMENT = 'EK-INT - Zuordnungstabelle UserID (LDAP) zu Rolle und entsprechender ID der Rolle (ZEK, WBL oder GF) - wird manuell über MSI (TAS) befüllt';
