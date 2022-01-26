CREATE TABLE [FF].[JachtVerlofVolgNummer] (
    [VolgNummer]          INT           NOT NULL,
    [RijksregisterNummer] NVARCHAR (50) NULL,
    [Naam]                NVARCHAR (50) NOT NULL,
    [Voornaam]            NVARCHAR (50) NOT NULL,
    [SoftDeleted]         BIT           DEFAULT ((0)) NOT NULL,
    [RowVersion]          ROWVERSION    NOT NULL,
    CONSTRAINT [PK_JachtVerlofVolgNummer] PRIMARY KEY CLUSTERED ([VolgNummer] ASC)
);

