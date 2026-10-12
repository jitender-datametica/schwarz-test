--==============================================================
-- Table: kostenstelle_mo_sum_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kostenstelle_mo_sum_1
   generated from Powerdesigner on Donnerstag, 22. Februar 2024 09:06:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.KOSTENSTELLE_MO_SUM_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   kjmo                                INTEGER     NOT NULL COMMENT 'Kalenderjahresmonat, z.Bsp 200908',
   kostenstelle_id                     VARCHAR(10)      NOT NULL COMMENT 'ID der Kostenstelle, z.Bsp. 9676-400. Aktuell nur Kostenstellen vom Level 15.',
   anz_mo_alter_kostenstelle           INTEGER     COMMENT 'Age of the cost center in months. The age starts growing from the month where the first employee_1 is assigned at this cost center, so the first one of the counts anz_mo_alter_kostenstelle_fe_i, anz_mo_alter_kostenstelle_fe_ii, anz_mo_alter_kostenstelle_fe_iii, anz_mo_alter_kostenstelle_fe_iv, anz_mo_alter_kostenstelle_fe_v, anz_mo_alter_kostenstelle_fe_vi, or anz_mo_alter_kostenstelle_me becomes 1.',
   anz_mo_alter_kostenstelle_fe_i      INTEGER     COMMENT 'The age of the cost center in months with regards to FE I employees, shr_ma_funktion_id beginn with 34 => level FE_I.',
   anz_mo_alter_kostenstelle_fe_ii     INTEGER     COMMENT 'The age of the cost center in months with regards to FE II employees, shr_ma_funktion_id beginn with 33 => level FE_II.',
   anz_mo_alter_kostenstelle_fe_iii    INTEGER     COMMENT 'The age of the cost center in months with regards to FE III employees, shr_ma_funktion_id beginn with 32 => level FE_III.',
   anz_mo_alter_kostenstelle_fe_iv     INTEGER     COMMENT 'The age of the cost center in months with regards to FE IV employees, shr_ma_funktion_id beginn with 23 => level FE_IV.',
   anz_mo_alter_kostenstelle_fe_v      INTEGER     COMMENT 'The age of the cost center in months with regards to FE V employees, shr_ma_funktion_id beginn with 22 => level FE_V.',
   anz_mo_alter_kostenstelle_fe_vi     INTEGER     COMMENT 'The age of the cost center in months with regards to FE VI employees, shr_ma_funktion_id beginn with 21 => level FE_VI.',
   anz_mo_alter_kostenstelle_ma        INTEGER     COMMENT 'The age of the cost center in months with regards to FE MA employees, shr_ma_funktion_id beginn with 1 => level MA.',
   anz_mo_alter_kostenstelle_gender_frau INTEGER     COMMENT 'The age of the cost center in months with regards to male gender employees.',
   anz_mo_alter_kostenstelle_gender_mann INTEGER     COMMENT 'The age of the cost center in months with regards to female gender employees.',
   anz_mo_alter_kostenstelle_bzg_00_03_mo INTEGER     COMMENT 'The age of the cost center in months with regards to employees who are in the company for up to 3 months (Betriebszugehörigkeit <= 3 Monate).',
   anz_mo_alter_kostenstelle_bzg_03_06_mo INTEGER     COMMENT 'The age of the cost center in months with regards to employees who are in the company for 3 to 6 months (Betriebszugehörigkeit 3-6 Monate).',
   anz_mo_alter_kostenstelle_bzg_06_12_mo INTEGER     COMMENT 'The age of the cost center in months with regards to employees who are in the company for 6 to 12 months (Betriebszugehörigkeit 6-12 Monate).',
   anz_mo_alter_kostenstelle_bzg_12_36_mo INTEGER     COMMENT 'The age of the cost center in months with regards to employees who are in the company for 12 to 36 months (or 1 to 3 years, Betriebszugehörigkeit 1-3 Jahre).',
   anz_mo_alter_kostenstelle_bzg_36_plus_mo INTEGER     COMMENT 'The age of the cost center in months with regards to employees who are in the company for more than 36 months (or more than 3 years, Betriebszugehörigkeit > 3 Jahre).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KOSTENSTELLE_MO_SUM PRIMARY KEY (mandant_id, kjmo, kostenstelle_id) NOT ENFORCED
)  COMMENT = 'SHR - monthly periodic snapshot_1 fact table. This table stores monthly periodic snapshots of ages of cost centers. These ages are calculated in relation to the month from which the first employee_1 was assigned to that cost center. Furthermore, the months since the first employees of certain categories (such as FE V or FE VI, male or female, etc.) are also stored.';
