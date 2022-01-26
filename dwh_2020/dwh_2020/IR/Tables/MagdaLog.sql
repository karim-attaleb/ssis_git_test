CREATE TABLE [IR].[MagdaLog] (
    [MagdaLogID]     INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Wanneer]        DATETIME        NOT NULL,
    [MagdaLogTypeID] NVARCHAR (15)   NOT NULL,
    [Referentie]     NVARCHAR (50)   NOT NULL,
    [Wat]            NVARCHAR (50)   NOT NULL,
    [Wie]            NVARCHAR (50)   NOT NULL,
    [Gebruiker]      NVARCHAR (50)   NULL,
    [Waarom]         NVARCHAR (50)   NULL,
    [Bericht]        NVARCHAR (MAX)  NULL,
    [OverWie]        NVARCHAR (50)   NULL,
    [Fout]           NVARCHAR (1000) NULL,
    [Doorlooptijd]   INT             NULL,
    [BronID]         NVARCHAR (15)   NOT NULL,
    CONSTRAINT [PK_MagdaLog] PRIMARY KEY CLUSTERED ([MagdaLogID] ASC) ON [DataLog],
    CONSTRAINT [FK_MagdaLog_MagdaLogType] FOREIGN KEY ([MagdaLogTypeID]) REFERENCES [IR].[MagdaLogType] ([MagdaLogTypeID])
) ON [DataLog] TEXTIMAGE_ON [DataLog];

