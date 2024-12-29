import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_owner_app/core/view_models/search_provider.dart';
import '../../core/models/product_model.dart';
import '../constants/assets_path.dart';
import '../widgets/feeds_product.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  late FocusNode _focusNode;

  List<ProductModel> _searchList = [];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: _searchBar(searchProvider),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: _searchController.text.isEmpty || _searchList.isEmpty
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: _searchController.text.isNotEmpty
                        ? Text(
                            'No results found :(',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          )
                        : SvgPicture.asset(
                            ImagePath.search,
                          ),
                  )
                : _showSearchResults(),
          ),
        ),
      ),
    );
  }

  Widget _showSearchResults() {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (MediaQuery.of(context).size.width) /
          (MediaQuery.of(context).size.width + 184),
      mainAxisSpacing: 8,
      children: List.generate(
        _searchList.length,
        (index) => ChangeNotifierProvider.value(
          value: _searchList[index],
          child: Center(
            child: FeedsProduct(
              product: _searchList[index],
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchBar(SearchProvider searchProvider) {
    return Material(
      elevation: 1,
      child: TextField(
        focusNode: _focusNode,
        autofocus: true,
        controller: _searchController,
        maxLines: 1,
        style: Theme.of(context).textTheme.bodyLarge,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Theme.of(context).cardColor,
          filled: true,
          isDense: true,
          hintText: 'Search',
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.tertiary),
          suffixIcon: _searchController.text.isEmpty
              ? null
              : IconButton(
                  onPressed: _searchController.text.isEmpty
                      ? null
                      : () {
                          _searchController.clear();
                          _focusNode.unfocus();
                        },
                  iconSize: 14,
                  color: Theme.of(context).colorScheme.tertiary,
                  icon: const Icon(Icons.clear),
                  padding: EdgeInsets.zero,
                  splashRadius: 14,
                ),
          suffixIconConstraints: const BoxConstraints(maxHeight: 14),
        ),
        onChanged: (value) {
          _searchController.text.toLowerCase();
          _searchList = searchProvider.searchQuery(value);
        },
      ),
    );
  }
}
