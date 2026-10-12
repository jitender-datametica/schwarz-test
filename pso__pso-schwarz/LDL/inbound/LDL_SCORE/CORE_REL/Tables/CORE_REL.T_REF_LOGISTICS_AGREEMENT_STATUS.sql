/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REF_LOGISTICS_AGREEMENT_STATUS
   GENERATED FROM POWERDESIGNER ON Donnerstag, 14. September 2023 11:59:43
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_REF_LOGISTICS_AGREEMENT_STATUS (
   logistics_agmt_status_cd            VARCHAR(20)     NOT NULL COMMENT 'Status of an agreement',
   logistics_agmt_status_descr         VARCHAR(100)    COMMENT 'Values are:	
            Created(Erstellt) - The contract status created indicates that a contract was created for the first time.
            Processed(Bearbeitet) - The contract status processed means that a change has been made to a contract and the processing has been completed. The contract is thus blocked from further changes.
            Checked(Geprüft) - The contract status checked indicates that a contract has been checked by a second employee (not the person who created the contract) -  from the internal organizational unit (contract management) - .
            Approved(Freigegeben) - The contract status released indicates that a contract has been released by freight purchasing as an internal organizational unit (foundation) - .
            Sent(Versendet) - The contract status sent denotes the status that a contract has been sent to the logistics service provider (if by post) -  or to freight purchasing (internal organizational unit) -  and logistics service provider (via Adobe Sign) - .
            signed(Unterschrieben) - The contract status signed indicates that a contract has been signed by both contracting parties.',
   logistics_agmt_status_descr_de      VARCHAR(100)    COMMENT 'German description of statuses:	
            Created(Erstellt) - The contract status created indicates that a contract was created for the first time.
            Processed(Bearbeitet) - The contract status processed means that a change has been made to a contract and the processing has been completed. The contract is thus blocked from further changes.
            Checked(Geprüft) - The contract status checked indicates that a contract has been checked by a second employee (not the person who created the contract) -  from the internal organizational unit (contract management) - .
            Approved(Freigegeben) - The contract status released indicates that a contract has been released by freight purchasing as an internal organizational unit (foundation) - .
            Sent(Versendet) - The contract status sent denotes the status that a contract has been sent to the logistics service provider (if by post) -  or to freight purchasing (internal organizational unit) -  and logistics service provider (via Adobe Sign) - .
            signed(Unterschrieben) - The contract status signed indicates that a contract has been signed by both contracting parties.',
   logistics_agmt_status_descr_en      VARCHAR(100)    COMMENT 'English description of statuses:		
            Created(Erstellt) - The contract status created indicates that a contract was created for the first time.
            Processed(Bearbeitet) - The contract status processed means that a change has been made to a contract and the processing has been completed. The contract is thus blocked from further changes.
            Checked(Geprüft) - The contract status checked indicates that a contract has been checked by a second employee (not the person who created the contract) -  from the internal organizational unit (contract management) - .
            Approved(Freigegeben) - The contract status released indicates that a contract has been released by freight purchasing as an internal organizational unit (foundation) - .
            Sent(Versendet) - The contract status sent denotes the status that a contract has been sent to the logistics service provider (if by post) -  or to freight purchasing (internal organizational unit) -  and logistics service provider (via Adobe Sign) - .
            signed(Unterschrieben) - The contract status signed indicates that a contract has been signed by both contracting parties.
            ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_REF_LOGISTICS_AGREEMENT_STATUS PRIMARY KEY (LOGISTICS_AGMT_STATUS_CD) NOT ENFORCED 
)  COMMENT = 'Agreement status describes the current work status/status of the contract. A distinction is made between different forms.';

