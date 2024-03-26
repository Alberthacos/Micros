#include <stdio.h>

float   Frecuencia_osc;             // Frecuencia del oscilador que se va a utilizar
float   Periodo_deseado;            // Tiempo a dejar pasar en microsegundos
int     No_NOPS;                    // Numero de Nops a utilizar

int     Ciclos_maquina_reales;      //Ciclos de maquina reales obtenidos con los datos ingresados
int     Ciclos_maquina_reales2;      //Ciclos de maquina reales obtenidos con los datos ingresados
int     Ciclos_maquina_reales3;      //Ciclos de maquina reales obtenidos con los datos ingresados
int     Periodo_real3;      //Ciclos de maquina reales obtenidos con los datos ingresados
int     Periodo_real2;      //Ciclos de maquina reales obtenidos con los datos ingresados
float   Periodo_real;               //Periodo real obtenido con los ciclos de maquina obtenidos

double  Periodo_Ciclo_maquina;      // Calcula la duracion de un ciclo de maquina con los datos ingresados
int     VAR1 = 0;                   //VAR1
int     VAR12 = 0;                  //VAR1
int     VAR13 = 0;                  //VAR1

int     VAR2 = 0;                   //VAR1
int     VAR23 = 0;                  //VAR1

int     VAR3 = 0;                   //VAR1

int  T2Max,T1Max,T3Max;

int Posibles_periodos[256][256], Datos=0;
int Valores1[256][256][256];

int main()
{
    printf("Ingresa la frecuencia del oscilador en MHz: ");
    scanf("%f", &Frecuencia_osc);
    printf("Ingresa el periodo deseado en microsegundos: ");
    scanf("%f", &Periodo_deseado);
    printf("Ingresa el numero de NOPs a utilizar: ");
    scanf("%d", &No_NOPS);

    Periodo_Ciclo_maquina = 4 * (1 / Frecuencia_osc);               // Tciclo maquina
    VAR1 = (Periodo_deseado - 5) / (No_NOPS + 3);                   // VAR1 obtenido y truncado al valor entero mas cercano
    //VAR1 = VAR1> 255 ? 255 : VAR1;                                  //condicion no superar 255

    Ciclos_maquina_reales = 5 + VAR1*(No_NOPS + 3);                 //Ciclos de maquina reales obtenidos
    Periodo_real = (5 + VAR1 * (No_NOPS + 3) * Periodo_Ciclo_maquina);//Periodo real obtenido con lo calculado
    T1Max = (5 + 256 * (No_NOPS + 3));//Periodo real obtenido con lo calculado
    printf("\nUn ciclo de maquina: %f [us]\n", Periodo_Ciclo_maquina);
    printf("-----------------------------------------------------------\n\n");
    printf("\n        PARA UNA VARIABLE: ");
    
    if(Periodo_real>T1Max)
    {
        printf("\nEl tiempo deseado es mayor al que puede ejecutar esta subrutina \n");
    }
    else
    {
        printf("VAR1: %d \n", VAR1);
        printf("Ciclos de maquina logrados: %d\n",Ciclos_maquina_reales);
        printf("Ciclos de maquina faltantes: %d\n",(int)((Periodo_deseado/Periodo_Ciclo_maquina)-Ciclos_maquina_reales));
        printf("tiempo de espera faltante: %d [us] \n\n",(int)(Periodo_deseado-Periodo_real));
    }
    printf("---------------------------------------------------------------\n\n");

    //CODIGO PARA DOS VARIABLES 
    
    printf("        PARA DOS VARIABLES: \n");

	for(int i=0;i<=255;i++){
		for(int j=0;j<=255;j++){
			Posibles_periodos[i][j]=(7+(4*j)+(No_NOPS+3)*(i*j))*Periodo_Ciclo_maquina;
		}
	}

    Datos = Posibles_periodos[0][0]; //El error inicial es el primer dato de la lista

    for (int i = 0; i <= 255; i++)
    {
        for (int j = 0; j <= 255; j++)
        {
            if (Periodo_deseado >= Posibles_periodos[i][j] && Datos < Posibles_periodos[i][j])  
            {
                Datos=Posibles_periodos[i][j];
                VAR12 = i;
                VAR2 = j;
            }
        }
    }

    Periodo_real2 = (7 + (4 * VAR2) + (No_NOPS + 3) * VAR12 * VAR2) * Periodo_Ciclo_maquina;
    Ciclos_maquina_reales2 = (7 + (4 * VAR2) + (No_NOPS + 3) * VAR12 * VAR2);
    T2Max = (7 + (4 * 256) + (No_NOPS + 3) * 256 * 256);
    if (Periodo_real2 > T2Max)
    {
        printf("El tiempo deseado es mayor al que puede ejecutar esta subrutina \n");
    }
    else
    {
        printf("VAR1:  %d\n", VAR12);
        printf("VAR2:  %d\n", VAR2);
        printf("Ciclos de maquina logrados:  %d\n", Periodo_real2);
        printf("Ciclos de maquina faltantes:  %d\n", (int)((Periodo_deseado/Periodo_Ciclo_maquina) - Ciclos_maquina_reales2));
        printf("Tiempo faltante:  %d [s]\n", (int)(Periodo_deseado - Periodo_real2));
    }

//////////////////////////////////////////////////////////////////////////
/////////////////////3 VARIABLES//////////////////////////////////////////

    printf("-----------------------------------------------------------\n\n");
    printf("\n        PARA TRES VARIABLES: ");

    	int Datos1=0, i, j, k;
	
	for(i=0;i<=255;i++){
		for(j=0;j<=255;j++){
			for(k=0;k<=255;k++){
				Valores1[i][j][k]=9+(4*i)*(k+1)+(i*j*k)*(No_NOPS+3);
			}
		}
	}
	
	Datos1=Valores1[0][0][0];

	for(i=0;i<=255;i++){
		for(j=0;j<=255;j++){
			for(k=0;k<=255;k++){
				if(Periodo_deseado >= Valores1[i][j][k] && Datos1 < Valores1[i][j][k]){
					Datos1 = Valores1[i][j][k];
					VAR13=i;
					VAR23=j;
					VAR3=k;
				}
			}
		}
	}

    Ciclos_maquina_reales3 = 9 + 4 * VAR13 * (1 + VAR3) + VAR13 * VAR23 * VAR3*(No_NOPS + 3);
    Periodo_real3 = (9 + 4 * VAR13 * (1 + VAR3) + VAR13 * VAR23 * VAR3 * (No_NOPS + 3)) * Periodo_Ciclo_maquina;
    T3Max = Periodo_real3 = (9 + 4 * 256 * (1 + 256) + 256 * 256 * 256 * (No_NOPS + 3)) * Periodo_Ciclo_maquina;

    printf("\nVAR1:  %d\n", VAR13);
    printf("VAR2:  %d\n", VAR23);
    printf("VAR3:  %d\n", VAR3);
    printf("Ciclos de maquina logrados:  %d\n", Periodo_real3);
    printf("Tiempo faltante:  %d [s]\n", (int)(Periodo_deseado - Periodo_real3));
    printf("Ciclos de maquina faltantes:  %d\n", (int)((Periodo_deseado/Periodo_Ciclo_maquina) - Ciclos_maquina_reales3));

    return 0;
}
