--==============================================================
-- Table: user_rolle_ek_int_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: user_rolle_ek_int_zu_1
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:19:36
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_SECURITY.USER_ROLLE_EK_INT_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   user_id                             VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'ID des MSI Users',
   rolle_id                            NUMBER(38,0)     COMMENT 'ID der Rolle (Zuweisung ob ZEK_1, WBL_1 (EKL) oder GF_1)',
   rolle_bez                           VARCHAR(30)      COLLATE 'en-ci' COMMENT 'Bezeichung der Rolle (ZEK_1, WBL_1 (EKL) oder GF_1)',
   zek_id                              VARCHAR(3)       COMMENT 'falls Rolle = ZEK_1 steht hier die Zentraleinkäufer - ID',
   wbl_id                              NUMBER(38,0)     COMMENT 'falls Rolle = WBL_1 steht hier die Warenbereichsleiter(EKL) ID ',
   gf_id                               NUMBER(38,0)     COMMENT 'falls Rolle = GF_1 steht hier dieGeschäftsführer ID',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_USER_ROLLE_EK_INT_ZU PRIMARY KEY (mandant_id, user_id) NOT ENFORCED
)  COMMENT = 'EK-INT - Zuordnungstabelle UserID (LDAP) zu Rolle und entsprechender ID der Rolle (ZEK_1, WBL_1 oder GF_1) - wird manuell über MSI (TAS) befüllt';
