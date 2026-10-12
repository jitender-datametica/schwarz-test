--==============================================================
-- Table: t_dim_logistics_agreement_status_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_logistics_agreement_status_2
   generated from Powerdesigner on Dienstag, 16. Juli 2024 13:39:50
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_LOGISTICS_AGREEMENT_STATUS_2 (
   logistics_agmt_status_cd            VARCHAR(20)     NOT NULL COMMENT 'Status_2 of an agreement',
   logistics_agmt_status_descr         VARCHAR(100)    COMMENT 'Values are:	
            Created(Erstellt) - The contract status_2 created indicates that a contract was created for the first time.
            Processed(Bearbeitet) - The contract status_2 processed means that a change has been made to a contract and the processing has been completed. The contract is thus blocked from further changes.
            Checked(Geprüft) - The contract status_2 checked indicates that a contract has been checked by a second employee_2 (not the person who created the contract) -  from the internal organizational unit_2 (contract management) - .
            Approved(Freigegeben) - The contract status_2 released indicates that a contract has been released by freight purchasing as an internal organizational unit_2 (foundation) - .
            Sent(Versendet) - The contract status_2 sent denotes the status_2 that a contract has been sent to the logistics service provider (if by post) -  or to freight purchasing (internal organizational unit_2) -  and logistics service provider (via Adobe Sign) - .
            signed(Unterschrieben) - The contract status_2 signed indicates that a contract has been signed by both contracting parties.
            ',
   logistics_agmt_status_descr_de      VARCHAR(100)    COMMENT 'German description of statuses:	
            Created(Erstellt) - The contract status_2 created indicates that a contract was created for the first time.
            Processed(Bearbeitet) - The contract status_2 processed means that a change has been made to a contract and the processing has been completed. The contract is thus blocked from further changes.
            Checked(Geprüft) - The contract status_2 checked indicates that a contract has been checked by a second employee_2 (not the person who created the contract) -  from the internal organizational unit_2 (contract management) - .
            Approved(Freigegeben) - The contract status_2 released indicates that a contract has been released by freight purchasing as an internal organizational unit_2 (foundation) - .
            Sent(Versendet) - The contract status_2 sent denotes the status_2 that a contract has been sent to the logistics service provider (if by post) -  or to freight purchasing (internal organizational unit_2) -  and logistics service provider (via Adobe Sign) - .
            signed(Unterschrieben) - The contract status_2 signed indicates that a contract has been signed by both contracting parties.
            ',
   logistics_agmt_status_descr_en      VARCHAR(100)    COMMENT 'English description of statuses:		
            Created(Erstellt) - The contract status_2 created indicates that a contract was created for the first time.
            Processed(Bearbeitet) - The contract status_2 processed means that a change has been made to a contract and the processing has been completed. The contract is thus blocked from further changes.
            Checked(Geprüft) - The contract status_2 checked indicates that a contract has been checked by a second employee_2 (not the person who created the contract) -  from the internal organizational unit_2 (contract management) - .
            Approved(Freigegeben) - The contract status_2 released indicates that a contract has been released by freight purchasing as an internal organizational unit_2 (foundation) - .
            Sent(Versendet) - The contract status_2 sent denotes the status_2 that a contract has been sent to the logistics service provider (if by post) -  or to freight purchasing (internal organizational unit_2) -  and logistics service provider (via Adobe Sign) - .
            signed(Unterschrieben) - The contract status_2 signed indicates that a contract has been signed by both contracting parties.
            ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_DIM_LOGISTICS_AGREEMENT_STATUS PRIMARY KEY (logistics_agmt_status_cd) NOT ENFORCED 
)  COMMENT = 'Agreement status_2 describes the current work status_2/status_2 of the contract. A distinction is made between different forms.';
