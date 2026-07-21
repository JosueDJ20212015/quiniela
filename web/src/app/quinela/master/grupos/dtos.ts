export interface GrupoDto {
  id: number;
  nombre: string;
  torneoId: number;
  torneo: string;
  active: boolean;
  createdAt?: string;
  createdBy?: string;
  updatedAt?: string;
  updatedBy?: string;
}

export interface TorneoOption {
  id: number;
  descripcion: string;
}
