CREATE TABLE IDN_OAUTH2_USER_CONSENT (
    ID INTEGER NOT NULL,
    USER_ID VARCHAR(255) NOT NULL,
    APP_ID CHAR(36) NOT NULL,
    TENANT_ID INTEGER DEFAULT -1 NOT NULL,
    CONSENT_ID VARCHAR(255) NOT NULL,

    PRIMARY KEY (ID),
    FOREIGN KEY (APP_ID) REFERENCES SP_APP (UUID) ON DELETE CASCADE,
    UNIQUE (USER_ID, APP_ID, TENANT_ID),
    UNIQUE (CONSENT_ID)
)
/
CREATE SEQUENCE IDN_OAUTH2_USER_CONSENT_SEQUENCE START WITH 1 INCREMENT BY 1 CACHE 20
/
CREATE OR REPLACE TRIGGER IDN_OAUTH2_USER_CONSENT_TRIGGER
    BEFORE INSERT
        ON IDN_OAUTH2_USER_CONSENT
        REFERENCING NEW AS NEW
            FOR EACH ROW
                BEGIN
                    SELECT IDN_OAUTH2_USER_CONSENT_SEQUENCE.nextval INTO :NEW.ID FROM dual;
                END;
/

CREATE TABLE IDN_OAUTH2_USER_CONSENTED_SCOPES (
    ID INTEGER NOT NULL,
    CONSENT_ID VARCHAR(255) NOT NULL,
    TENANT_ID INTEGER DEFAULT -1 NOT NULL,
    SCOPE VARCHAR(255) NOT NULL,
    CONSENT NUMBER(1,0) DEFAULT 1 NOT NULL,

    PRIMARY KEY (ID),
    FOREIGN KEY (CONSENT_ID) REFERENCES IDN_OAUTH2_USER_CONSENT (CONSENT_ID) ON DELETE CASCADE,
    UNIQUE (CONSENT_ID, SCOPE)
)
/
CREATE SEQUENCE IDN_OAUTH2_USER_CONSENTED_SCOPES_SEQUENCE START WITH 1 INCREMENT BY 1 CACHE 20
/
CREATE OR REPLACE TRIGGER IDN_OAUTH2_USER_CONSENTED_SCOPES_TRIGGER
    BEFORE INSERT
        ON IDN_OAUTH2_USER_CONSENTED_SCOPES
        REFERENCING NEW AS NEW
            FOR EACH ROW
                BEGIN
                    SELECT IDN_OAUTH2_USER_CONSENTED_SCOPES_SEQUENCE.nextval INTO :NEW.ID FROM dual;
                END;
/