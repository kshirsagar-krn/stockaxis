import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stockaxis/data/models/pricing_model.dart';
import 'package:stockaxis/domain/usecases/custom_textfield.dart';
import '../../../generated/assets.dart';
import '../blocs/pricing_bloc.dart';
import '../widgets/custom_bottom.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  @override
  void initState() {
    BlocProvider.of<PricingBloc>(context).add(FetchLittleMasters());
    BlocProvider.of<PricingBloc>(context).add(FetchEmergingMarketLeaders());
    BlocProvider.of<PricingBloc>(context).add(FetchLargeCapFocus());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// AppBar --
    AppBar customAppbar = AppBar(
      backgroundColor: Colors.white,
      centerTitle: false,
      title: Text(
        "Pricing",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      actions: const [
        Icon(
          Icons.headphones,
          size: 24,
        ),
        SizedBox(
          width: 16,
        ),
      ],
      bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 1),
          child: Container(
            color: Colors.grey.shade300,
            height: 1,
            width: double.infinity,
          )),
    );



    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppbar,
      bottomSheet: const CustomBottom(),
      body: BlocBuilder<PricingBloc, PricingState>(
        builder: (context, state) {
          // Loading --
          if (state is PricingLoading) {
            return const Center(
              child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  )),
            );
          }
          // Loaded --
          else if (state is PricingLoaded) {
            final dataProduct1 =   context.read<PricingBloc>().product1;
            final dataProduct2 =   context.read<PricingBloc>().product2;
            final dataProduct3 =   context.read<PricingBloc>().product3;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [

                  /// 1st Product
                  if(dataProduct1 != [])
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            offset: const Offset(0, 0),
                            color: Colors.black.withOpacity(0.25),
                          )
                        ]),
                    child: Column(
                      children: [
                        // top Card Headers
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.svgsGem,
                              height: 30,
                              width: 30,
                              color: Colors.orange,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Little Masters",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          height: 1,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                  Text(
                                    "Small Cap",
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.info_outline,
                              color: Colors.grey.shade600,
                            )
                          ],
                        ),
                        // Middle sections
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: 1,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                        ),

                        const Text(
                          "Invest in up-trnding Smallcap stocks screened through MiLARS strategy to generate weath",
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        DropdownButtonFormField<PricingModel>(

                            hint: const Text("Select A Plan (include of GST)"),
                            decoration: CustomDecoration.inputDecoration(
                                context,
                                borderRadius: 6),
                            items: [
                              const DropdownMenuItem<PricingModel>(value: null,child: Text("Select A Plan (include of GST)"),),
                              ...dataProduct1
                                .map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child:  Text("${value.pDuration} - Rs. ${value.pAmount}"),
                              );
                            }).toList()],
                            onChanged: (data) {
                              context.read<PricingBloc>().add(SelectSmallCap(data));
                            }),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20,),
                  /// 2nd Product
                  if(dataProduct2 != [])
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              offset: const Offset(0, 0),
                              color: Colors.black.withOpacity(0.25),
                            )
                          ]),
                      child: Column(
                        children: [
                          // top Card Headers
                          Row(
                            children: [
                              SvgPicture.asset(
                                Assets.svgsGem,
                                height: 30,
                                width: 30,
                                color: Colors.orange,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Emerging Market Leaders",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                        height: 1,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "Mid Cap",
                                      style:
                                      Theme.of(context).textTheme.labelSmall,
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.info_outline,
                                color: Colors.grey.shade600,
                              )
                            ],
                          ),
                          // Middle sections
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey.shade300,
                          ),

                          const Text(
                            "Generate wealth by riding momentum in Midcap stocks screened through MILARS strategy",
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          DropdownButtonFormField<PricingModel>(
                              hint: const Text("Select A Plan (include of GST)"),
                              disabledHint: const Text("Select A Plan (include of GST)"),
                              decoration: CustomDecoration.inputDecoration(
                                  context,
                                  borderRadius: 6),
                              items:[
                                const DropdownMenuItem<PricingModel>(value: null,child: Text("Select A Plan (include of GST)"),),
                              ...dataProduct2
                                  .map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child:  Text("${value.pDuration} - Rs. ${value.pAmount}"),
                                );
                              }).toList()],
                              onChanged: (data) {
                                context.read<PricingBloc>().add(SelectMidCap(data));
                              }),
                        ],
                      ),
                    ),

                  const SizedBox(height: 20,),
                  /// 2rd Product
                  if(dataProduct3 != [])
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              offset: const Offset(0, 0),
                              color: Colors.black.withOpacity(0.25),
                            )
                          ]),
                      child: Column(
                        children: [
                          // top Card Headers
                          Row(
                            children: [
                              SvgPicture.asset(
                                Assets.svgsGem,
                                height: 30,
                                width: 30,
                                color: Colors.orange,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Large Cap Focus",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                        height: 1,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "Large Cap",
                                      style:
                                      Theme.of(context).textTheme.labelSmall,
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.info_outline,
                                color: Colors.grey.shade600,
                              )
                            ],
                          ),
                          // Middle sections
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey.shade300,
                          ),

                          const Text(
                            "Achieve stable growth in your portfolio by investing  in Bluechip stocks passed through MILARS strategy",
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          DropdownButtonFormField<PricingModel>(
                              hint: const Text("Select A Plan (include of GST)"),
                              decoration: CustomDecoration.inputDecoration(
                                  context,
                                  borderRadius: 6),
                              items: [
                                const DropdownMenuItem<PricingModel>(value: null,child: Text("Select A Plan (include of GST)"),),
                                //
                                ...dataProduct3
                                    .map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child:  Text("${value.pDuration} - Rs. ${value.pAmount}"),
                                  );
                                }).toList()
                              ],
                              onChanged: (data) {
                                context.read<PricingBloc>().add(SelectLargeCap(data));
                              }),
                        ],
                      ),
                    ),
                ],
              ),
            );
          }
          // Error --
          else if (state is PricingError) {
            return Text(
              state.errorMsg,
              style: Theme.of(context).textTheme.titleMedium,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
