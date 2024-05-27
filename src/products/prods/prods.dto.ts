import { IsNotEmpty, Length } from "class-validator";

export class ProductDTO {
    
    @IsNotEmpty()
    @Length(3,40,{
        message:"ID must be between 3 and 40 characters"
    })
    id: string;

    @IsNotEmpty()
    @Length(3,40,{
        message:"Name must be between 3 and 30 characters"
    })
    name: string;
    desc: string;
    price: number;
    quantity: number;

}