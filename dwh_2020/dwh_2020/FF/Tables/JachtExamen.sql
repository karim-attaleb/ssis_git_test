CREATE TABLE [FF].[JachtExamen] (
    [JachtExamenID]       INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [DossierNummer]       NVARCHAR (15) NOT NULL,
    [Jaartal]             SMALLINT      NULL,
    [RijksregisterNummer] NVARCHAR (50) NULL,
    [Naam]                NVARCHAR (50) NULL,
    [Voornaam]            NVARCHAR (50) NULL,
    [Adres]               NVARCHAR (50) NULL,
    [PostCode]            NVARCHAR (15) NULL,
    [Gemeente]            NVARCHAR (50) NULL,
    [NisCode]             NVARCHAR (15) NULL,
    [LandID]              NVARCHAR (5)  NULL,
    [SoftDeleted]         BIT           DEFAULT ((0)) NOT NULL,
    [RowVersion]          ROWVERSION    NOT NULL,
    CONSTRAINT [PK_JachtExamen] PRIMARY KEY CLUSTERED ([JachtExamenID] ASC),
    CONSTRAINT [UK_JachtExamen] UNIQUE NONCLUSTERED ([DossierNummer] ASC, [Jaartal] ASC)
);


GO
CREATE NONCLUSTERED INDEX [AK_JachtExamen]
    ON [FF].[JachtExamen]([DossierNummer] ASC)
    ON [Indexes];

