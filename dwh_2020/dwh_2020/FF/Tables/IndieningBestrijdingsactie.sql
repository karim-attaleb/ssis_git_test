CREATE TABLE [FF].[IndieningBestrijdingsactie] (
    [IndieningBestrijdingsactieID] INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]                  INT            NOT NULL,
    [BestrijdingsactieID]          NVARCHAR (15)  NOT NULL,
    [BeginDatum]                   DATETIME       NULL,
    [Frequentie]                   NVARCHAR (50)  NULL,
    [Aantal]                       INT            NULL,
    [Beschrijving]                 NVARCHAR (200) NULL,
    [SoftDeleted]                  BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]                   ROWVERSION     NOT NULL,
    CONSTRAINT [PK_IndieningBestrijdingsactie] PRIMARY KEY CLUSTERED ([IndieningBestrijdingsactieID] ASC),
    CONSTRAINT [FK_IndieningBestrijdingsactie_Bestrijdingsactie] FOREIGN KEY ([BestrijdingsactieID]) REFERENCES [FF].[Bestrijdingsactie] ([BestrijdingsactieID]),
    CONSTRAINT [FK_IndieningBestrijdingsactie_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID])
);

