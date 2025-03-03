
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockaxis/core/constants/app_colors.dart';
import 'package:stockaxis/domain/usecases/custom_button.dart';
import 'package:stockaxis/presentation/pricing/blocs/pricing_bloc.dart';

class CustomBottom extends StatelessWidget {
  const CustomBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PricingBloc, PricingState>(
  builder: (context, state) {

    if(state is PricingLoaded){
      double smallCapPrice = double.parse("${context.read<PricingBloc>().selectSmallCap?.pAmount ?? 0}")  ;
      double midCapPrice = double.parse("${context.read<PricingBloc>().selectMidCap?.pAmount ?? 0 }");
      double largeCapPrice = double.parse("${context.read<PricingBloc>().selectLargeCap?.pAmount ?? 0}");
      double totalAmount = 0;

      //check discount ---
      int count = (smallCapPrice > 0 ? 1 : 0) + (midCapPrice > 0 ? 1 : 0) + (largeCapPrice > 0 ? 1 : 0);
      totalAmount = smallCapPrice + midCapPrice + largeCapPrice;
      // Apply discount if at least two values are present
      if (count == 2) {
        totalAmount = totalAmount * 0.8;
      }


      return SafeArea(
        child: Container(
          color: Colors.white,
          child:  Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(count == 2)
              Container(
                width: double.infinity,
                color: Colors.green,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text("You will save Rs. ${smallCapPrice + midCapPrice + largeCapPrice - totalAmount} on this plan", style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.white
                ),),
              ),

              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Rs. $totalAmount", style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),),
                          Text("inclusive GST", style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w300,
                          ),),
                        ],
                      ),
                    ),
                    CustomButton(
                      textFontSize: 16,
                      buttonText: "Proceed for Payment",
                      onClick: (){},
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10,)
            ],
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  },
);
  }
}
