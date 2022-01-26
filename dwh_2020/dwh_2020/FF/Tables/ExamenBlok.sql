CREATE TABLE [FF].[ExamenBlok] (
    [ExamenBlokID]     INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ExamenID]         INT             NOT NULL,
    [ExamenBlokTypeID] NVARCHAR (15)   NOT NULL,
    [Score]            DECIMAL (10, 2) NULL,
    [Geslaagd]         BIT             DEFAULT ((0)) NOT NULL,
    [ExtraPunt]        BIT             DEFAULT ((0)) NOT NULL,
    [SoftDeleted]      BIT             DEFAULT ((0)) NOT NULL,
    [RowVersion]       ROWVERSION      NOT NULL,
    PRIMARY KEY CLUSTERED ([ExamenBlokID] ASC),
    CONSTRAINT [FK_ExamenBlok_Examen] FOREIGN KEY ([ExamenID]) REFERENCES [FF].[Examen] ([ExamenID]),
    CONSTRAINT [FK_ExamenBlok_ExamenBlokType] FOREIGN KEY ([ExamenBlokTypeID]) REFERENCES [FF].[ExamenBlokType] ([ExamenBlokTypeID])
);

